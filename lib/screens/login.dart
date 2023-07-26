import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:me_reminder/screens/sign_up.dart';
import 'package:me_reminder/widgets/login_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isVisible;
  var _enteredEmail;
  var _enteredPassword;
  
  @override
  void initState() {
    super.initState();
    isVisible = false;
  }


  @override
  Widget build(BuildContext context) {

    gSignIn() async {
      final gUser = await GoogleSignIn().signIn();
      final gAuth = await gUser!.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credentials);
    }

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
                        "Welcome Back",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Login with your email and password",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 40),
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
                          icon: (isVisible) ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
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
                          onPressed: () async {
                            try {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _enteredEmail,
                                      password: _enteredPassword);
                            } on FirebaseAuthException catch (error) {
                              String errorText = "";
                              switch (error.code) {
                                case "user-not-found":
                                  errorText =
                                      "User with this email not found";
                                  break;
                                case "invalid-email":
                                  errorText = "Please enter a valid email";
                                  break;
                                case "wrong-password":
                                  errorText = "Please the correct password password";
                                  break;
                                default:
                                  errorText = "Some error occured";
                              }
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorText),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 40),
                      // Image.asset("lib/assets/images/seperator.png"),
                      // const SizedBox(height: 20),
                      // SizedBox(
                      //   height: 50,
                      //   width: double.maxFinite,
                      //   child: FilledButton(
                      //     onPressed: () {
                      //       gSignIn();
                      //     },
                      //     style: const ButtonStyle().copyWith(
                      //       backgroundColor:
                      //           MaterialStatePropertyAll(Colors.grey[200]),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Image.asset("lib/assets/images/google_logo.png"),
                      //         const SizedBox(
                      //           width: 15,
                      //         ),
                      //         const Text(
                      //           "Continue with Google",
                      //           style: TextStyle(
                      //             color: Colors.black45,
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (ctx) => const SignUpScreen()),
                              (route) => false);
                        },
                        child: Text(
                          "New User ?",
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