import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojexct/components/button.dart';
import 'package:finalprojexct/components/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final Function()? onTap;
  const SignupScreen({super.key, required this.onTap});


  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();


  //signup method
  void signup() async{
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    if (pwController.text != confirmPwController.text) {
      Navigator.pop(context);
      displayErrorMessage("Password Does Not Match");
    }
    try{
      UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: pwController.text,
      );

      //storing user data in Firestore
      FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email!)
      .set({
        'uid' : userCredential.user!.uid,
        'username' : emailController.text.split('@')[0],
        'bio' : 'Enter a Bio...'
      });

      if (context.mounted) Navigator.pop(context);
    }on FirebaseAuthException catch (e) {
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(height: 25),

                // slogan
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

                // password
                MyTextField(
                  controller: pwController,
                  hintText: "Enter Password...",
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password
                MyTextField(
                  controller: confirmPwController,
                  hintText: "Confirm Password...",
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signup,
                ),

                const SizedBox(height: 25),

                // don't have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Signed Up for an Account?",
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login here",
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
      ),
    );
  }
}
