import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_code/MainApp/home_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationID;
  final String mobileNumber;
  const VerifyOtpScreen({
    super.key,
    required this.verificationID,
    required this.mobileNumber,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String otp = '';
  final _auth = FirebaseAuth.instance;
  final CollectionReference collectionReferenceUserMaster = FirebaseFirestore
      .instance
      .collection('titoUserMaster');

  //////////////////////////FUNCTIONS///////////////////////

  void loginWithOTP() async {
    final credentials = PhoneAuthProvider.credential(
      verificationId: widget.verificationID,
      smsCode: otpController.text.toString(),
    );

    await _auth
        .signInWithCredential(credentials)
        .whenComplete(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        })
        .then((value) {
          addDataToFireBase();
        }).onError((error, stackTrace) {
          print(error.toString());
        });
  }

  Future<void> addDataToFireBase() async {
    await collectionReferenceUserMaster.add({
      'mobile_number': '+91${widget.mobileNumber}',
      'uuid': '91${widget.mobileNumber}',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              TextFormField(
                controller: otpController,
                key: ValueKey('otp'),
                validator: (value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Please enter OTP';
                  } else if (value.toString().trim().length < 6) {
                    return 'Please enter 6 digit otp';
                  } else {
                    return null;
                  }
                },
                maxLength: 10,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                  icon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  loginWithOTP();
                },
                child:
                    isLoading
                        ? CircularProgressIndicator()
                        : Text('SUBMIT OTP'),
              ),
              SizedBox(height: 10),
              TextButton(onPressed: () {}, child: Text('Change Number')),
            ],
          ),
        ),
      ),
    );
  }
}
