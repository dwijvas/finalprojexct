import 'package:finalprojexct/components/button.dart';
import 'package:finalprojexct/components/textfields.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final Function()? onTap;
  const SignupScreen({super.key, required this.onTap});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
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

                // userNameController textfield
                MyTextField(
                  controller: userNameController,
                  hintText: "Enter Username...",
                  obscureText: false,
                ),

                const SizedBox(height: 10),

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
                  onTap: (){},
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
