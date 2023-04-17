from django.db import models

class Transacao(models.Model):
    banco_origem = models.CharField(max_length=30, blank=False, null=False)
    agencia_origem = models.CharField(max_length=4, blank=False, null=False)
    conta_origem = models.CharField(max_length=7, blank=False, null=False)
    banco_destino = models.CharField(max_length=30, blank=False, null=False)
    agencia_destino = models.CharField(max_length=4, blank=False, null=False)
    conta_destino = models.CharField(max_length=7, blank=False, null=False)
    valor_transacao = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)
    data_hora_transacao = models.DateTimeField(null=False, blank=False)

class Usuario(models.Model):
    nome = models.CharField(blank=False, null=False, max_length=50)
    email = models.EmailField(blank=False, null=False, unique=True)
    senha = models.CharField(blank=False, null=False, max_length=200)
    esta_ativo = models.BooleanField(default=True)

