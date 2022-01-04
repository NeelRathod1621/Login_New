import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/Helper%20Function/helperFunction.dart';
import 'package:test_app/services/firebase_service.dart';

import 'constant.dart';

class signUp extends StatelessWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: signUpScreen(),
    );
  }
}

class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmpassword = TextEditingController();
firebaseServices _services = firebaseServices();
HelperFunction _helperFunction = HelperFunction();
final formKey = GlobalKey<FormState>();

final _imageFileProvider = StateProvider<File?>((ref) => null);
  ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> pickImage(ImageSource imageSource) async {
    var tempFile = await _imagePicker.getImage(source: imageSource);
    if (tempFile != null) {
      context.read(_imageFileProvider).state = File(tempFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 220, 224, 221),
            Color.fromARGB(255, 142, 148, 144)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            child: Stack(
              children: [
                Form(
                  key: formKey,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 180,
                    ),
                    elevation: 5,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),
                         Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              labelText: 'Name',
                            ),
                             validator: (ValueKey){
                            if(ValueKey!.isEmpty){
                              return "Name is Required";
                            }
                            else{
                              return null;
                            }
                          },
                          ),
                        ),
                         Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                              validator: (ValueKey){
                            if(ValueKey!.isEmpty ||!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(ValueKey)){
                              return "Enter Valid Email";
                            }
                            else{
                              return null;
                            }
                          },
                          ),
                        ),
                       
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                             validator: (ValueKey){
                            if(ValueKey!.isEmpty ||!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(ValueKey)){
                              return "Password Must Have 1 Capital and 8 Character Long";
                            }
                            else{
                              return null;
                            }
                          },
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: _confirmpassword,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              //border: OutlineInputBorder(),
                              labelText: 'Confirm Password',
                            ),
                            validator: (ValueKey){
                            if (ValueKey!.isEmpty || ValueKey !=  _passwordController.text) {
                              return "Password Mismatched";
                            }
                            else{
                              return null;
                            }
                          },
                          ),
                        ),
                      SizedBox(
                        height: 24,
                      ),
                        
                        Container(
                          margin: EdgeInsets.all(24),
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 17, 12, 171),
                              borderRadius: BorderRadius.circular(40)),
                          child: TextButton(
                            onPressed: () async{
                              bool sub = await _services.signUpEmail(_emailController.text, _passwordController.text)?? false;
                              if(sub){
                                await _helperFunction.setPageName("homeScreen");
                                 Navigator.pushReplacementNamed(context, HOME);
                               }
                               else{
                                 print("Wrong Credential");
                               }
                                if (formKey.currentState!.validate()){
                               final snackBar = SnackBar(content: Text('Submitting'));
                               _scaffoldKey.currentState!.showSnackBar(snackBar);
                             }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Muli',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               Stack(
                 children: [
                   Container(
                     margin: EdgeInsets.only(top: 130, left: 130),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.25))
                            ]),
                      ), 
                Positioned(
                  bottom:0.0,
                  right:0.0,
                  child: Container(
                    height: 40,
                    width: 40,
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Profile Image",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            CircleAvatar(
                                              backgroundColor:
                                              Theme.of(context).primaryColor,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                await pickImage(
                                                    ImageSource.camera);
          //                                              uploadPic();
                                                Navigator.of(context).pop();
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    radius: 30,
                                                    child: Icon(
                                                      Icons.camera,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text("Camera",
                                                      style:
                                                      TextStyle(fontSize: 12),
                                                      textAlign:
                                                      TextAlign.center),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await pickImage(
                                                    ImageSource.gallery);
          //                                              uploadPic();
                                                Navigator.of(context).pop();
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.green,
                                                    radius: 30,
                                                    child: Icon(
                                                      Icons.image,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text("Gallery",
                                                      style:
                                                      TextStyle(fontSize: 12),
                                                      textAlign:
                                                      TextAlign.center),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                );
                              });
                        },
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                        )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.25))
                        ]),
                  ),
                ),
                 ],
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
