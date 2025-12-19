import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_code/MainApp/home_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationID;
  const VerifyOtpScreen({super.key, required this.verificationID});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String otp = '';
  final _auth = FirebaseAuth.instance;

  //////////////////////////FUNCTIONS///////////////////////

  void loginWithOTP() async {
    final credentials = PhoneAuthProvider.credential(
      verificationId: widget.verificationID,
      smsCode: otpController.text.toString(),
    );

    await _auth.signInWithCredential(credentials).whenComplete(() {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    },);

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
