import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_code/LoginPagesOfApp/phone_number_login.dart';
import 'package:just_code/MainApp/home_screen.dart';
import 'package:just_code/LoginPagesOfApp/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isLoading = false;
  String emailAddress = '';
  String password = '';
  String errorFromFirebaseExceptionsForEmail = '';
  String errorFromFirebaseExceptionsForPassword = '';

  FirebaseAuth _auth = FirebaseAuth.instance;

  /////////////////////FUNCTIONS////////////////////

  trySubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      login();
    }
  }

  void login() {
    setState(() {
      isLoading = true;
    });
    _auth
        .signInWithEmailAndPassword(
          email: emailAddressController.text.toString(),
          password: passwordController.text.toString(),
        )
        .then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          setState(() {
            isLoading = false;
          });
        })
        .onError((error, stackTrace) {
          debugPrint(error.toString());
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  void dispose() {
    super.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SizedBox(
          height: 400,
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: ValueKey('emailAddress'),
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return 'Please enter your Password';
                    } else {
                      return null;
                    }
                  },
                  controller: emailAddressController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter email id',
                    icon: Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return 'Please enter Paswword';
                    } else if (value.toString().trim().length <= 5) {
                      return 'Min 6 characters needed';
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    icon: Icon(Icons.password_outlined),
                    suffixIcon:
                        isPasswordVisible
                            ? IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye),
                            )
                            : IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye_outlined),
                            ),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    trySubmit();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[50],
                    elevation: 5,
                    shadowColor: Colors.black12,
                  ),
                  child:
                      isLoading
                          ? CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          )
                          : Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.black87),
                          ),
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text('NEW REGISTRATION!!'),
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhoneNumberLogin(),
                      ),
                    );
                  },
                  child: Text('Login with Mobile Number'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
