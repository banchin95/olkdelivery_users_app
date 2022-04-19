import 'package:flutter/material.dart';


class SimpleAppBar extends StatelessWidget with PreferredSizeWidget
{
  String? title1;
  String? title2;

  final PreferredSizeWidget? bottom;

  SimpleAppBar({this.bottom,  this.title1, this.title2});

  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
        ),
      ),
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: RichText(
        text: TextSpan(
          children: <TextSpan>
          [
            TextSpan(text: title1!, style: const TextStyle(color: Colors.white, fontSize: 25,fontFamily: "Righteous", letterSpacing: 3, fontWeight: FontWeight.bold,),),
            TextSpan(text: title2!, style: const TextStyle(color: Colors.orange, fontSize: 25,fontFamily: "Righteous", letterSpacing: 3, fontWeight: FontWeight.bold,),),
          ],
        ),
      ),

    );
  }
}