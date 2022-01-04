import 'package:flutter/material.dart';
import 'package:test_app/Helper%20Function/helperFunction.dart';
import 'package:test_app/screens/constant.dart';

class home extends StatefulWidget {
  const home({ Key? key }) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

HelperFunction _helperFunction = HelperFunction();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(onPressed: () async{
        await _helperFunction.setPageName("Screen");
        Navigator.pushReplacementNamed(context, LOGIN);
      },
      child: Text("logout"),
      ),
    );
  }
}