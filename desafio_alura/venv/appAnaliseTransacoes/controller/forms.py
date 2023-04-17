from django import forms

class UploadFileForm(forms.Form):
    arquivos_csv = forms.FileField(required=True, help_text="Selecione o arquivo CSV")