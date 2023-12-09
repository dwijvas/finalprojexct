import 'package:finalprojexct/components/button.dart';
import 'package:finalprojexct/components/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //logging the user in
  void login() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (Navigator.of(context).canPop()) {
        Navigator.pop(context);
      }
    }on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayErrorMessage(e.code);
    }
  }
  void displayErrorMessage(String msg){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(msg),
        )
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.group,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(height: 25),

              //welcome message
              const Text(
                'MessageMe',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),

              const SizedBox(height: 50),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: "Enter Email...",
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: "Enter Password...",
                obscureText: true,
              ),

              const SizedBox(height: 10),


              //login button
              MyButton(
                text: "Login",
                onTap: login,
              ),

              const SizedBox(height: 20),

              //navigate to signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not Registered Yet?",
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Please Sign Up Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
