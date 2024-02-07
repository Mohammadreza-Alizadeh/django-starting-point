from django.shortcuts import render

# Create your views here.
from django.shortcuts import render
from django.contrib.auth.views import LoginView, LogoutView
from django.urls import reverse_lazy
from django.contrib import messages
from .forms import UserLoginForm, UserRegisterForm
from django.views.generic.edit import FormView
from django.contrib.auth import login


class StudentLoginView(LoginView):
    redirect_authenticated_user = True
    template_name = 'accounts/login.html' # you have to create form https://www.geeksforgeeks.org/formview-class-based-views-django/
    form_class = UserLoginForm 


    # def get_success_url(self):
    #     return reverse_lazy('app:view') 
    
    def form_invalid(self, form):
        return self.render_to_response(self.get_context_data(form=form))
    


class StudentRegisterView(FormView):
    template_name = 'accounts/register.html' # you have to create form https://www.geeksforgeeks.org/formview-class-based-views-django/
    form_class = UserRegisterForm
    redirect_authenticated_user = True

    # success_url = reverse_lazy('app:view')
    
    def form_valid(self, form):
        user = form.save()
        if user:
            login(self.request, user)
        
        return super(StudentRegisterView, self).form_valid(form)