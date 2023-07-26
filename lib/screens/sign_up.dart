import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_reminder/screens/login.dart';
import 'package:me_reminder/widgets/login_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _enteredEmail;
  var _enteredPassword;
  var _enteredName;
  var isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = false;
  }

  void _registerUser() async {
    try {
      final userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _enteredEmail, password: _enteredPassword);

      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);
    } on FirebaseAuthException catch (error) {
      String errorText = "";
      switch (error.code) {
        case "email-already-in-use":
          errorText = "This email is already registered";
          break;
        case "invalid-email":
          errorText = "Please enter a valid email";
          break;
        case "weak-password":
          errorText = "Please enter a strong password";
          break;
        default:
          errorText = "Some error occured";
      }
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(error.code.replaceAll("-", " ").split(" ").map((word) => word[0].toUpperCase()+word.substring(1)).join(" ")),
          content: Text(errorText),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Close"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset("lib/assets/images/logo.png")),
              Container(
                padding: const EdgeInsets.all(40),
                child: Form(
                  child: Column(
                    children: [
                      Text(
                        "Register",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Create a new user account",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 40),
                      LoginInput(
                        hint: "Name",
                        prefix: const Icon(Icons.person_add_alt_1),
                        getText: (text) {
                          _enteredName = text;
                        },
                        visibility: true,
                      ),
                      const SizedBox(height: 20),
                      LoginInput(
                        hint: "Email",
                        prefix: const Icon(Icons.mail),
                        getText: (text) {
                          _enteredEmail = text;
                        },
                        visibility: true,
                      ),
                      const SizedBox(height: 20),
                      LoginInput(
                        hint: "Password",
                        prefix: const Icon(Icons.key),
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: (isVisible)
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        getText: (text) {
                          _enteredPassword = text;
                        },
                        visibility: isVisible,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.maxFinite,
                        height: 50,
                        child: FilledButton(
                          onPressed: _registerUser,
                          child: Text(
                            "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (ctx) => const LoginScreen()),
                              (route) => false);
                        },
                        child: Text(
                          "Already have an account ?",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
