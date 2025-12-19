import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_code/LoginPagesOfApp/verify_otp_screen.dart';

class PhoneNumberLogin extends StatefulWidget {
  const PhoneNumberLogin({super.key});

  @override
  State<PhoneNumberLogin> createState() => _PhoneNumberLoginState();
}

class _PhoneNumberLoginState extends State<PhoneNumberLogin> {
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;

  ////////////////////////////FUNCTIONS/////////////////////////////
  trySubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      loginWithPhoneNumber();
    }
  }

  void loginWithPhoneNumber() {
    print('hi there');
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text.trim().toString(),
      verificationCompleted: (_) {
        debugPrint("verification complete ");
        setState(() {
          isLoading = false;
        });
      },
      verificationFailed: (e) {
        setState(() {
          isLoading = false;
        });
        debugPrint("failed "+e.toString());
      },
      codeSent: (String verificationID, int? token) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => VerifyOtpScreen(verificationID: verificationID),
          ),
        ).whenComplete(() {
          debugPrint(' coming');
          setState(() {
            isLoading = false;
          });
        });
      },
      codeAutoRetrievalTimeout: (e) {
        setState(() {
          isLoading = false;
        });
        debugPrint("Error from auto retrieval timeout "+e.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login With Phone Number'), centerTitle: true),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
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
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  trySubmit();
                },
                child:
                    isLoading ? CircularProgressIndicator() : Text('GET OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
