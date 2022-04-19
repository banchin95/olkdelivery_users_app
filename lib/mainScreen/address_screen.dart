import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olkdelivery_users_app/mainScreen/save_address_screen.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/address_changer.dart';
import '../global/global.dart';
import '../models/address.dart';
import '../widgets/address_design.dart';
import '../widgets/progress_bar.dart';


class AddressScreen extends StatefulWidget
{
  final double? totalAmount;
  final String? sellerUID;

  AddressScreen({this.totalAmount, this.sellerUID});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
          ),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Адрес"),
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.add_location, color: Colors.white,),
        onPressed: ()
        {
          //save address to user collection
          Navigator.push(context, MaterialPageRoute(builder: (c)=> SaveAddressScreen()));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Выбрать адрес:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          Consumer<AddressChanger>(builder: (context, address, c){
            return Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("users")
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("userAddress")
                    .snapshots(),
                builder: (context, snapshot)
                {
                  return !snapshot.hasData
                      ? Center(child: circularProgress(),)
                      : snapshot.data!.docs.length == 0
                      ? Container()
                      : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index)
                    {
                      return AddressDesign(
                        currentIndex: address.count,
                        value: index,
                        addressID: snapshot.data!.docs[index].id,
                        totalAmount: widget.totalAmount,
                        sellerUID: widget.sellerUID,
                        model: Address.fromJson(
                            snapshot.data!.docs[index].data()! as Map<String, dynamic>
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
