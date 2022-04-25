import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          title: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Jost",
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan> [
                TextSpan(text: "Нужные", style: TextStyle(color: Colors.green),),
                TextSpan(text: " Люди", style: TextStyle(color: Colors.orange),),
              ],
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.blueGrey,),
                child: Text(
                  "Войти",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: "Jost",
                  ),
                ),
              ),
              Tab(
                icon: Icon(Icons.person, color: Colors.blueGrey,),
                child: Text(
                  "Регистрация",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: "Jost",
                  ),
                ),
              ),
            ],
            indicatorColor: Colors.orangeAccent,
            indicatorWeight: 4,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.yellow,
              ],
            ),
          ),
          child: const TabBarView(
            children: [
              LoginScreen(),
              RegisterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
