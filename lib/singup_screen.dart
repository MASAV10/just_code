import 'package:flutter/material.dart';
import 'package:just_code/login_page.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  String emailAddress = '';
  String password = '';

  /////////////////////FUNCTIONS////////////////////
  
  trySubmit(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
      submitData();
    }
  }

  submitData(){

  }





  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('SING UP'),
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
                  controller: passwordController ,
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
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[50],
                    elevation: 5,
                    shadowColor: Colors.black12,
                  ),
                  child: Text(
                    'Sing Up',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                SizedBox(height: 8),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                }, child: Text('New Registraion!!'))
              ],
            ),
         
         
          ),
        ),
      ),
    );
  
  }
}