import bcrypt

class Senha:
    def __init__(self, senha_plana):
        self.senha = bcrypt.hashpw(senha_plana, bcrypt.gensalt(1)) 
