from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('upload/', views.upload_file, name='upload_file'),
    path('limpa/', views.limpa, name='limpa'),
    path('cadastrar/', views.cadastrar_usuario, name='cadastrar'),
    path('atualizar/', views.atualizar_usuario, name='atualiza'),
    path('apagar/', views.apagar_usuario, name='apagar'),
    path('usuarios/', views.usuarios, name='usuarios'),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
]