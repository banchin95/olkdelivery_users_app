import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:olkdelivery_users_app/assistantMethods/assistant_methods.dart';
import 'package:olkdelivery_users_app/global/global.dart';
import 'package:olkdelivery_users_app/mainScreen/home_screen.dart';


class PlacedOrderScreen extends StatefulWidget
{
  String? addressID;
  double? totalAmount;
  String? sellerUID;

  PlacedOrderScreen({this.sellerUID, this.totalAmount, this.addressID});

  @override
  _PlacedOrderScreenState createState() => _PlacedOrderScreenState();
}



class _PlacedOrderScreenState extends State<PlacedOrderScreen>
{
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  addOrderDetails()
  {
    writeOrderDetailsForUser({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Оплата при доставке",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUID,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
    });

    writeOrderDetailsForSeller({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Оплата при доставке",
      "orderTime": orderId,
      "isSuccess": true,
      "sellerUID": widget.sellerUID,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId,
    }).whenComplete((){
      clearCartNow(context);
      setState(() {
        orderId="";
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        Fluttertoast.showToast(msg: "Поздравляем, заказ успешно оформлен.");
      });
    });
  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  Future writeOrderDetailsForSeller(Map<String, dynamic> data) async
  {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  @override
  Widget build(BuildContext context)
  {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey,
                Colors.amber,
              ],
              begin:  FractionalOffset(0.0, 0.0),
              end:  FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset("images/delivery.jpg"),

            const SizedBox(height: 12,),

            ElevatedButton(
              child: const Text("Разместить заказ"),
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
              ),
              onPressed: ()
              {
                addOrderDetails();
              },
            ),

          ],
        ),
      ),
    );
  }
}

