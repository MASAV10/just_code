import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_code/singup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  ///////////////////////////////////////FUNCTIIONS///////////////////////////////////////////////
  trySubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      submitForm();
    }
  }

  submitForm() {
    addDataToUserMaster();
  }

  Future<void> addDataToUserMaster() async {
    await collectionReferenceUserMaster.add({
      'email_address': emailAddressController.text.trim(),
      'username': userNameController.text.trim(),
      'mobile_number': '+91' + phoneNumberController.text.trim(),
      'uuid': '91' + phoneNumberController.text.trim(),
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
                    } else if (value.toString().trim().length == 10) {
                      return 'Please enter 10 digit mobile number';
                    } else {
                      return null;
                    }
                  },
                  maxLength: 10,
                  keyboardType: TextInputType.numberWithOptions(),
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
                    } else if (value.toString().trim().contains('@')) {
                      return 'Email is not Formatted properly';
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
                    } else if (value.toString().trim().length <= 6) {
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
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SingupScreen()),
                    );
                  },
                  child: Text('Already Have a Account Sing Up!!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
