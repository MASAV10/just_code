import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_code/MainApp/home_screen.dart';


class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController employeeNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mobileNUmberController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  //image related vaiables
  final ImagePicker picker = ImagePicker();
  XFile? filePathOfProfilePhoto;

  void chooseProfilePhotoFromGallery() async {
    XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        filePathOfProfilePhoto = photo;
      });
    } else {
      XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        filePathOfProfilePhoto = photo;
      });
    }
  }

   @override
  void dispose() {
    dobController.dispose();
    employeeNumberController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    mobileNUmberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.grey[200],
                  width: 300,
                  child: Column(
                    spacing: 2,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        height: 200,
                        child:
                            filePathOfProfilePhoto != null
                                ? Image.asset(
                                  File(filePathOfProfilePhoto!.path).toString(),
                                  fit: BoxFit.cover,
                                )
                                : Icon(Icons.person_2, size: 200),
                      ),
                      SizedBox(height: 10),
                      TextButton.icon(
                        onPressed: () {
                          chooseProfilePhotoFromGallery();
                        },
                        icon: Icon(Icons.perm_identity_sharp),
                        label: Text('Choose Photo'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Please Enter Your Full Name ',
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        controller: fullNameController,
                        decoration: InputDecoration(
                          label: Text('Enter your name'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Divider(indent: 16, endIndent: 16),
                      Text(
                        'please Enter Your Empolyee Number',
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        controller: employeeNumberController,
                        decoration: InputDecoration(
                          label: Text('Enter your Empolyee Number'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Divider(indent: 16, endIndent: 16),
                      Text('Please enter Your DOB', textAlign: TextAlign.left),
                      TextFormField(
                        controller: dobController,
                        decoration: InputDecoration(
                          label: Text('Enter your DOB'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Divider(indent: 16, endIndent: 16),
                      Text('Entered Email-id', textAlign: TextAlign.left),
                      TextFormField(
                        //readOnly: true,
                        controller: emailController,
                        decoration: InputDecoration(
                          label: Text('Email'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Divider(indent: 16, endIndent: 16),
                      Text(
                        'Please enter your Mobile Number',
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        controller: mobileNUmberController,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          label: Text('Enter your Mobile NUmber'),
                          prefixText: '+91',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Divider(indent: 16, endIndent: 16),
                      ElevatedButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: 'Profile Saved Successfully',
                          );
                          setState(() {});
                        },
                        child: Text('Save Profile'),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}