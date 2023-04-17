from django.db import models
from django.contrib.auth.models import (
    BaseUserManager, AbstractBaseUser
)

class MyUserManager(BaseUserManager):
    def create_user(self, name, email, password=None, is_active=True, is_admin=False):
        if not email:
            raise ValueError('Users must have an email address')

        user = self.model(
            email=self.normalize_email(email),
        )

        user.set_password(password)
        user.is_active = is_active
        user.is_admin = is_admin
        user.name = name
        user.save(using=self._db)
        return user
    def create_superuser(self, name, email, password=None, is_active=True
                        , is_admin=True):
        user = self.create_user(name, email, password=password
                                , is_active=is_active, is_admin=is_admin)
        user.save(using=self._db)
        return user

class User(AbstractBaseUser):
    name = models.CharField(blank=False, null=False, max_length=50)
    email = models.EmailField(blank=False, null=False, unique=True)
    password = models.CharField(blank=False, null=False, max_length=200)
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    objects = MyUserManager()

    USERNAME_FIELD = 'name'
    REQUIRED_FIELDS = ['email', 'password', 'is_active', 'is_admin', 'name']

    def __str__(self):
        return self.name

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True
        
    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True