from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from django import forms
from .models import User
from django.contrib.auth.forms import AuthenticationForm


class CustomUserCreationForm(UserCreationForm):

    class Meta:
        model = User
        fields = ("email",)


class CustomUserChangeForm(UserChangeForm):

    class Meta:
        model = User
        fields = ("email",)




class UserLoginForm(AuthenticationForm):
    username = forms.EmailField(label='ایمیل', required=True)
    password = forms.CharField(label='رمز عبور', required=True, widget=forms.PasswordInput())

    """ 
    you can use crispy forms 
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.add_input(Submit('submit', 'ورود',css_class='w-100 text-center'))
    
    """

class UserRegisterForm(UserCreationForm):
    class Meta:
        model = User
        fields = ('email', 'password1', 'password2', )

    """
    use crispy forms for this
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.add_input(Submit('submit', 'ثبت نام',css_class='w-100 text-center'))
    """
