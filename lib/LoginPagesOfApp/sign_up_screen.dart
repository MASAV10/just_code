import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:just_code/HelpingFiles/cool_alert.dart';
import 'package:just_code/MainApp/home_screen.dart';
import 'package:just_code/LoginPagesOfApp/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  CollectionReference collectionReferenceUserMaster = FirebaseFirestore.instance
      .collection('titoUserMaster');

  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String emailAddress = '';
  String password = '';
  String userName = '';
  String phoneNumber = '';
  bool isPasswordVisible = false;
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  String errorFromFirebaseExceptionsForEmail = '';
  String errorFromFirebaseExceptionsForPassword = '';

  ///////////////////////////////////////FUNCTIIONS///////////////////////////////////////////////
  trySubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      submitForm();
    }
  }

  submitForm() {
    setState(() {
      isLoading = true;
    });

    try {
      _auth.createUserWithEmailAndPassword(
        email: emailAddressController.text.toString().trim(),
        password: passwordController.text.toString().trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains('email')) {
        setState(() {
          errorFromFirebaseExceptionsForEmail = e.message.toString();
          emailAddressController.clear();
          isLoading = false;
        });
      } else if (e.message!.contains('password')) {
        setState(() {
          errorFromFirebaseExceptionsForPassword = e.message.toString();
          passwordController.clear();
          emailAddressController.clear();
          isLoading = false;
        });
      }
    }

    addDataToUserMaster();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    setState(() {
      isLoading = false;
    });
  }

  Future<void> addDataToUserMaster() async {
    await collectionReferenceUserMaster.add({
      'email_address': emailAddressController.text.trim(),
      'username': userNameController.text.trim(),
      'mobile_number': '+91${phoneNumberController.text.trim()}',
      'uuid': '91${phoneNumberController.text.trim()}',
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('SIGN UP'),
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
                  key: ValueKey('userName'),
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return 'Please enter your name';
                    } else {
                      return null;
                    }
                  },
                  controller: userNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Enter your Name',
                    icon: Icon(Icons.person_4_outlined),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: phoneNumberController,
                  key: ValueKey('phoneNumber'),
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return 'Please enter mobile number';
                    } else if (value.toString().trim().length < 10) {
                      return 'Please enter 10 digit mobile number';
                    } else {
                      return null;
                    }
                  },
                  maxLength: 10,
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Enter your Mobile Number',
                    icon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(height: 8),
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
                            strokeWidth: 3,
                          )
                          : Text(
                            'SUBMIT',
                            style: TextStyle(color: Colors.black87),
                          ),
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );

                    MyCoolAlerts().myError(contentOfAlert: 'fffffffffddddddddddd', context: context);
                  },
                  child: Text("Already Have Account LOGIN!!"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
