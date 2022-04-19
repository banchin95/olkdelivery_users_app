import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olkdelivery_users_app/models/items.dart';
import '../mainScreen/order_details_screen.dart';


class OrderCard extends StatelessWidget
{
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCard({
   this.itemCount,
   this.data,
   this.orderID,
   this.seperateQuantitiesList,
  });

  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderDetailsScreen(orderID: orderID)));
      },
      child: Container(
      decoration: const BoxDecoration(
      color: Colors.black12,
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      height: itemCount! * 100,
      child: ListView.builder(
        itemCount: itemCount,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index)
        {
          Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
          return placedOrderDesignWidget(model, context, seperateQuantitiesList![index]);
        },
      ),
      ),
    );
  }
}


Widget placedOrderDesignWidget(Items model, BuildContext context, seperateQuantitiesList)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 100,
    color: Colors.white,
    child: Row(
      children: [
        Image.network(model.thumbnailUrl!, width: 120,),
        const SizedBox(width: 40.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      model.title!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40,),
                  const Text(
                    "₽ ",
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  Text(
                    model.price.toString(),
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  const SizedBox(width: 10,),
                ],
              ),

              const SizedBox(height: 10,),

              Row(
                children: [
                  const Text(
                    "x ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      seperateQuantitiesList,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Jost",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}