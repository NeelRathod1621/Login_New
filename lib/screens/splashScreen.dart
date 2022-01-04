import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Helper%20Function/helperFunction.dart';
import 'package:test_app/screens/constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  HelperFunction _helperFunctions = HelperFunction();

Future<void> decideNextScreen() async {
    Future.delayed(Duration(seconds: 4), () async {
      String pageName = await _helperFunctions.getPageName();
      if(pageName == "homeScreen") {
      Navigator.pushReplacementNamed(context, HOME);
      } else {
        Navigator.pushReplacementNamed(context, LOGIN);
      }
    });
  }

  

  @override
  void initState() {
    super.initState();
    
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
  decideNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /*new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: new Image.asset(
                    'asset/images/Panda.jpg',
                    height: 25.0,
                    fit: BoxFit.scaleDown,
                  ))
            ],
          ),*/
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'asset/images/Panda.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
