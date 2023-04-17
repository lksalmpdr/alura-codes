from django.contrib.auth.decorators import login_required
from datetime import timedelta, timezone
from urllib.request import HTTPRedirectHandler
from django.shortcuts import render
from django.http import HttpResponse
from .models import Transacao, Usuario
from .controller.forms import UploadFileForm
from .controller.handle_uploaded_file import handle_uploaded_file
from .controller.cripto_bcrypt import Senha

def authenticate(request):
    try:
        if request.POST['email'] == "master@master.com" and request.POST['senha'] == "master":
            request.session['autenticado'] = True
            request.session['email'] = request.POST['email']
            request.session['nome'] = "Master"
            request.session['expira'] = timezone.now() + timedelta(minutes=3000)
            return True
        else:
            senha = request.POST['senha']
            usuario = Usuario.objects.get(email=request.POST['email'], senha=Senha(senha).senha)
            
            if usuario.esta_ativo and timezone.now() < request.session['expira']:
                request.session['email'] = usuario.email
                request.session['autenticado'] = True
                request.session['nome'] = usuario.nome
                request.session['expira'] = timezone.now() + timedelta(minutes=30)
                return True
            else:
                request.session['autenticado'] = False
                return False
    except:
        request.session['autenticado'] = False
        return False
    

def logout(request):
    request.session.flush()
    return render(request, 'login.html')

def login(request):
    #if request.session['autenticado']:
        return render(request, 'index.html')
    #else:
    #    resultado_autenticacao = authenticate(request)
    #    if resultado_autenticacao:
    #        HTTPRedirectHandler.redirect_url = '/'
                        # render(request, 'index.html')
    #    else:
    #        return render(request, 'login.html', {'erro':'ok'})

@login_required(login_url='/login/')
def index(request):
    return render(request, 'index.html')

def usuarios(request):
    #if request.session['autenticado']:
        usuarios = Usuario.objects.all().exclude(esta_ativo=False, email= request.session['email'])
        return render(request, 'usuarios.html', {'usuarios': usuarios})
    #else:
    #    return render(request, 'login.html', {'erro':'ok'})
    
@login_required(login_url='/login/')
def cadastrar_usuario(request):
    #if request.session['autenticado']:
        nome = request.POST['nome']
        email = request.POST['email']
        senha = request.POST['senha']
        senha = Senha(senha).senha

        usuario = Usuario(nome, email, senha, True)
        usuario.save(force_update=False)

        usuarios = Usuario.objects.all().exclude(esta_ativo=False, email= request.session['email'])

        return render(request, 'usuarios.html', {'usuarios': usuarios, 'cadastro':'ok'})
    #else:
    #    return render(request, 'login.html', {'erro':'ok'})

@login_required(login_url='/login/')
def atualizar_usuario(request):
    #if request.session['autenticado']:
        usuario = Usuario.objects.get(email=request.POST['email'])
        usuario.nome = request.POST['nome']
        usuarios = Usuario.objects.all().exclude(esta_ativo=False, email= request.session['email'])

        return render(request, 'usuarios.html', {'usuarios': usuarios,'atualizado':'ok'})
    #else:
    #    return render(request, 'login.html', {'erro':'ok'})

@login_required(login_url='/login/')
def apagar_usuario(request):
    #if request.session['autenticado']:
        #apenas exclusao logica
        usuario = Usuario.objects.get(email=request.POST['email'])
        usuario.esta_ativo = False
        usuarios = Usuario.objects.all().exclude(esta_ativo=False, email= request.session['email'])

        return render(request, 'usuarios.html', {'usuarios':usuarios, 'apagado':'ok'})
    #else:
    #    return render(request, 'login.html', {'erro':'ok'})

@login_required(login_url='/login/')
def limpa(request):
    #if request.session.get('autenticado'):
        Transacao.objects.all().delete()
        return HttpResponse( '<h1>Tabela Transacoes Limpa</h1>')
    #else:
    #    return render(request, 'login.html', {'erro':'ok'})



@login_required(login_url='login/')
def upload_file(request):
    #if request.session['autenticado']:
        if request.method == 'POST':
            form = UploadFileForm(request.POST, request.FILES)
            if form.is_valid():
                linhas = handle_uploaded_file(request.FILES['arquivos_csv'])
                persistidos, nao_persistidos = 0, 0
                for linha in linhas:
                    dados = linha.split(',')
                    transacao = Transacao(banco_origem=dados[0], agencia_origem=dados[1], conta_origem=dados[2], banco_destino=dados[3], agencia_destino=dados[4], conta_destino=dados[5], valor_transacao=dados[6], data_hora_transacao=dados[7])
                    transacao_existe = Transacao.objects.filter(banco_origem=dados[0], agencia_origem=dados[1], conta_origem=dados[2], banco_destino=dados[3], agencia_destino=dados[4], conta_destino=dados[5], valor_transacao=dados[6], data_hora_transacao=dados[7])
                    if not transacao_existe.exists():
                        persistidos += 1
                        transacao.save()
                    else:
                        nao_persistidos += 1
                return render(request, 'importacao.html', {'upload':'ok', 'persistidos':persistidos, 'nao_persistidos':nao_persistidos})
            else:
                return render(request, 'importacao.html',{'upload':'invalid'} )
        else:
            return render(request, 'importacao.html', {'upload': 'fail'} )
    #else:
    #    return render(request, 'login.html', {'erro':'ok'})
