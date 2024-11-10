import 'package:demo_firebase/pages/home_page.dart';
import 'package:demo_firebase/utils/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  bool isSecure = false;
  bool isKeyboardVisible = false;

  LoginFunc(String email, String password, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print("Login Success!");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      // print(e.code);
      if (e.code == 'invalid-credential') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Invalid Credential",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  RegisterFunc(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("Register Success");
      await FirebaseAuth.instance.signOut();
      setState(() {
        FocusScope.of(context).unfocus();
        usernameController.clear();
        passwordController.clear();
        emailController.clear();
        isLoading = true;
        isLogin = true;
      });
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Email Already in Use!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Colors.blueAccent.withOpacity(0.7),
        title: isLogin ? 'Login Here!' : 'Register Here!',
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  height: isKeyboardVisible ? 0 : 230,
                  width: isKeyboardVisible ? 250 : 400,
                  child: Lottie.asset(
                    isLogin ? 'assets/login.json' : 'assets/register.json',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                !isLogin
                    ? TextFormField(
                        autovalidateMode: isLogin
                            ? AutovalidateMode.disabled
                            : AutovalidateMode.onUserInteraction,
                        controller: usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username is required Fields!";
                          } else if (value.length <= 3) {
                            return "Username is too small";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          usernameController.text = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent.withOpacity(0.6),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent.withOpacity(0.6),
                              width: 1.5,
                            ),
                          ),
                          label: const Text("Username"),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: isLogin
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required Fields!';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please Enter A Valid Email Address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: BorderSide(
                        color: Colors.blueAccent.withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: BorderSide(
                        color: Colors.blueAccent.withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                    label: const Text("Email Address"),
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  autovalidateMode: isLogin
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  obscureText: isSecure ? false : true,
                  obscuringCharacter: "*",
                  validator: (value) {
                    // Check if the password meets the criteria
                    if (value == null || value.isEmpty) {
                      return 'Password is required Fields!';
                    } else if (value.length < 8 || value.length > 12) {
                      return 'Password must be between 8 and 12 characters!';
                    } else if (!RegExp(
                            r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])')
                        .hasMatch(value)) {
                      return 'Password must contain at least one uppercase letter, one numeric character, and one special character!';
                    } else {
                      return null; // Clear the error if validation passes
                    }
                  },
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isSecure = !isSecure;
                          });
                        },
                        icon: isSecure
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: BorderSide(
                        color: Colors.blueAccent.withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: BorderSide(
                        color: Colors.blueAccent.withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                    label: const Text("Password"),
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                    onPressed: () async {
                      // String ema = emailController.text;
                      // String pass = passwordController.text;
                      if (_formKey.currentState!.validate()) {
                        isLogin
                            ? LoginFunc(
                                emailController.text,
                                passwordController.text,
                                context,
                              )
                            : RegisterFunc(
                                emailController.text, passwordController.text);
                      }
                    },
                    child: isLogin
                        ? isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                        : isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                      _formKey.currentState!.reset();
                      FocusScope.of(context).unfocus();
                    });
                  },
                  child: isLogin
                      ? const Text("Don't have an Account? Sign Up")
                      : const Text("Already Sign Up? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
