import 'package:flutter/material.dart';
import 'package:olkdelivery_users_app/assistantMethods/cart_Item_counter.dart';
import 'package:olkdelivery_users_app/mainScreen/cart_screen.dart';
import 'package:provider/provider.dart';


class MyAppBar extends StatefulWidget with PreferredSizeWidget
{
  final PreferredSizeWidget? bottom;
  final String? sellerUID;

  MyAppBar({this.bottom, this.sellerUID});

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height) : Size(56, 30+AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: ()
        {
          Navigator.pop(context);
        },
      ),
      automaticallyImplyLeading: true,
      title: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 25,
            fontFamily: "Righteous",
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan> [
            TextSpan(text: "OLK", style: TextStyle(color: Colors.white),),
            TextSpan(text: "DELIVERY", style: TextStyle(color: Colors.orange),),
          ],
        ),
      ),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white,),
              onPressed: ()
              {
                //send user to cart screen
                Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreen(sellerUID: widget.sellerUID)));
              },
            ),
            Positioned(
              child: Stack(
                children: [
                  const Icon(
                    Icons.brightness_1,
                    size: 25.0,
                    color: Colors.green,
                  ),
                  Positioned(
                    top: 5,
                    right: 8,
                    child: Center(
                      child: Consumer<CartItemCounter>(
                        builder: (context, counter, c)
                        {
                          return Text(
                            counter.count.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 12,),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
