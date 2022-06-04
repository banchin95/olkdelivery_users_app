import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../global/global.dart';
import '../mainScreen/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'auth_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation()
  {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
    {
      //войти в аккаунт
      loginNow();
    }
    else
    {
      showDialog(
        context: context,
        builder: (c)
        {
          return ErrorDialog(
            message: "Пожалуйста введите э.почту/пароль",
          );
        }
      );
    }
  }

  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return LoadingDialog(
            message: "Проверка данных",
          );
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );
    });
    if(currentUser != null)
    {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async
  {
    await FirebaseFirestore.instance.collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
          if(snapshot.exists)
          {
            if(snapshot.data()!["status"] == "approved")
            {
              await sharedPreferences!.setString("uid", currentUser.uid);
              await sharedPreferences!.setString("email", snapshot.data()!["email"]);
              await sharedPreferences!.setString("name", snapshot.data()!["name"]);
              await sharedPreferences!.setString("photoUrl", snapshot.data()!["photoUrl"]);

              List<String> userCartList = snapshot.data()!["userCart"].cast<String>();
              await sharedPreferences!.setStringList("userCart", userCartList);

              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
            }
            else
            {
              firebaseAuth.signOut();
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "Админ заблокировал ваш аккаунт. \n\nНапишите: banchin95@gmail.com");
            }
          }
          else
          {
            firebaseAuth.signOut();
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));

            showDialog(
                context: context,
                builder: (c)
                {
                  return ErrorDialog(
                    message: "Запись не существует."
                  );
                }
            );
          }

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                "images/login.png",
                height: 270,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Электронная почта",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Пароль",
                  isObsecre: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            child: const Text(
              "Войти",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightGreen,
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15,),
            ),
            onPressed: ()
            {
              formValidation();
            },
          ),
          const SizedBox(height: 30,),
          Container(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                ),
                children: <TextSpan>
                [
                  TextSpan(text: "При входе или регистрации вы принимаете условия\n",
                  style: TextStyle(color: Colors.black,),),
                  TextSpan(text: "ползовательского соглашения",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = ()
                      {
                        launch('https://drive.google.com/file/d/1CeZno2d9na2a9NIMWRXFuzAipQBHrsju/view?usp=sharing');
                      },
                  ),
                  TextSpan(text: " и ",
                    style: TextStyle(color: Colors.black,),),
                  TextSpan(text: "политикой конфиденциальности.",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = ()
                      {
                        launch('https://drive.google.com/file/d/1CeZno2d9na2a9NIMWRXFuzAipQBHrsju/view?usp=sharing');
                      },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}
