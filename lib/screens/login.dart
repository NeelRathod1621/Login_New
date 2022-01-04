import 'package:flutter/material.dart';
import 'package:test_app/Helper%20Function/helperFunction.dart';
import 'package:test_app/screens/signup.dart';
import 'package:test_app/services/firebase_service.dart';
import 'constant.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
bool checkpassword = true;
firebaseServices _services = firebaseServices();
HelperFunction _helperFunction = HelperFunction();
final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
                          controller: _emailController,
                          decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                            labelText: 'Enter Your Email',
                            //hintText: 'abc@gmail.com',
                          ),
                          validator: (ValueKey){
                            if(ValueKey!.isEmpty ||!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(ValueKey)){
                              return "Enter Your Valid Email";
                            }
                            else{
                              return null;
                            }
                          },
                        
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: checkpassword,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            //border: OutlineInputBorder(),
                            labelText: 'Password',
                            suffixIcon: IconButton(onPressed: () {
                              setState(() {
                                checkpassword = !checkpassword;
                              }
                              );
                            },
                            icon: Icon(checkpassword? Icons.visibility :Icons.visibility_off),
                            )
                          ),
                           validator: (ValueKey){
                            if(ValueKey!.isEmpty ){
                              return "Enter Your Password";
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Color.fromARGB(255, 17, 12, 171),
                            fontSize: 15,
                            fontFamily: 'Muli',
                          ),
                        ),
                      ),
                      Container(
                        //margin: EdgeInsets.only(top: 10),
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 17, 12, 171),
                            borderRadius: BorderRadius.circular(40)),
                        child: TextButton(
                          onPressed: () async{
                             bool check = await _services.signInEmail(_emailController.text, _passwordController.text)?? false;
                             if(check){
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
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Muli',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New User? ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 17, 12, 171),
                              fontSize: 14,
                              fontFamily: 'Muli',
                            ),
                          ),
                          TextButton(
                            
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => signUp()));
                            },
                            
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                color: Color.fromARGB(255, 17, 12, 171),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Muli',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 130),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('asset/images/Panda.jpg'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
