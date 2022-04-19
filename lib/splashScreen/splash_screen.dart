import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../authentication/auth_screen.dart';
import '../global/global.dart';
import '../mainScreen/home_screen.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  fullScreen()
  {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  startTimer()
  {
    Timer(const Duration(seconds: 3), () async {
      //Регистрация барбыт дьон
      if(firebaseAuth.currentUser != null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
      }
      //Регистрация барбатах или аккаунт киирбэххэ сылдьар
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    fullScreen();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset("images/welcome.png"),
              ),

              const SizedBox(height: 10,),

             Padding(
                padding: const EdgeInsets.all(18.0),
                child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 45,
                        fontFamily: "Righteous",
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan> [
                        TextSpan(text: "OLK", style: TextStyle(color: Colors.black),),
                        TextSpan(text: "DELIVERY", style: TextStyle(color: Colors.orangeAccent),),
                      ],
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
