import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

class firebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool?> signUpEmail(String Email, String Password)
  async{
    try{
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: Email,
        password: Password
  );
  if(userCredential != null){
    return true;
  }
 return false;
    }
    catch(e){
      print(e.toString());
    }
  }
  Future<bool?> signInEmail(String Email, String Password)
  async{
    try{
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: Email,
        password: Password
  );
  if(userCredential != null){
    return true;
  }
 return false;
    }
    catch(e){
      print(e.toString());
    }
  }
}