import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  var _enteredName;
  var isLogin;

  @override
  void initState() {
    super.initState();
    isVisible = false;
    isLogin = true;
  }

  gSignIn() async {
    final gUser = await GoogleSignIn().signIn();
    final gAuth = await gUser!.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }

  void emailSignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);
    } on FirebaseAuthException catch (error) {
      String errorText = "";
      switch (error.code) {
        case "user-not-found":
          errorText = "User with this email not found";
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
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(error.code
              .replaceAll("-", " ")
              .split(" ")
              .map((word) => word[0].toUpperCase() + word.substring(1))
              .join(" ")),
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

  void registerUser() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _enteredEmail, password: _enteredPassword);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);

      FirebaseAuth.instance.currentUser!.updateDisplayName(_enteredName);

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
          title: Text(error.code
              .replaceAll("-", " ")
              .split(" ")
              .map((word) => word[0].toUpperCase() + word.substring(1))
              .join(" ")),
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
                        (isLogin) ? "Welcome Back" : "Register",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 5),
                      Text(
                         (isLogin) ? "Login with your email and password" : "Create a new user account",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 40),
                      if(!isLogin)
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
                          onPressed: (isLogin) ? emailSignIn : registerUser,
                          child: Text(
                            (isLogin) ? "Login" : "Sign Up",
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
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          (isLogin) ? "New User ?" : "Already have an account ?",
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
