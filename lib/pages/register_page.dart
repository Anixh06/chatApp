import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController  _emailController = TextEditingController(); 
  final TextEditingController  _pwController = TextEditingController();
  final TextEditingController  _confirmpwController = TextEditingController();

  final void Function() onTap;
    RegisterPage({super.key, required this.onTap});
    
//register
  // ignore: non_constant_identifier_names
  void Register(BuildContext context){
    final auth = AuthService();

    //password match -->create user
    if(_pwController.text == _confirmpwController.text){
      try{
        auth.signUpWithEmailPassword(
          _emailController.text, 
          _pwController.text
          );
      } catch(e){
        showDialog(
        context: context,
        builder: (context)=> AlertDialog(
        title: Text(e.toString()),
       ),
       );
        
      }
      //password dont match --> show error
    } else {
      showDialog(
        context: context,
        builder: (context)=> const AlertDialog(
        title: Text("Passwords do not match"),
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
            "Lets get you started!",
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
          const SizedBox(height: 10),

          //confirm pw textfield
          MyTextfield(
            hinttext: "Confirm Password",
            obscureText: true,
            controller: _confirmpwController,
          ),
        
          const SizedBox(height: 25),

          //login button
          MyButton(
            text: "Register",
            onTap: () => Register(context),
            ),

          const SizedBox(height: 25),

          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
                Text(
                  "already have an account?",
                  style: 
                  TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login Now",
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
