import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
final TextEditingController  _emailController = TextEditingController();
final TextEditingController  _pwController = TextEditingController();

final void Function() onTap;      
  LoginPage({super.key, required this.onTap});


//login
  void login(BuildContext context) async{
    //auth service
    // ignore: non_constant_identifier_names
    final authService = AuthService();
    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text, 
        _pwController.text,
        );
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
       builder: (context)=> AlertDialog(
        title: Text(e.toString()),
       ),
       );
    }
    
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body:  Center(
        child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          //logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),

          //welcome back message
          Text(
            "Welcome Back, you've been missed!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,  
            ),
          ),
          const SizedBox(height: 25),

          //email textfield
          MyTextfield(
            hinttext: "Email",
            obscureText: false,
            controller: _emailController,
          ),
                  
          const SizedBox(height: 10),

          //pw textfield
          MyTextfield(
            hinttext: "Password",
            obscureText: true,
            controller: _pwController,
          ),
        
          const SizedBox(height: 25),

          //login button
          MyButton(
            text: "login",
            onTap: () => login(context),
            ),

          const SizedBox(height: 25),

          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
                Text(
                  "Not a member?",
                  style: 
                  TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap ,
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                
             ],
          )
         

        ],
        ),
    ),
    );
  }
}


