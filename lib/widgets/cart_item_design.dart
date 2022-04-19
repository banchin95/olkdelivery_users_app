import 'package:flutter/material.dart';
import 'package:olkdelivery_users_app/models/items.dart';


class CartItemDesign extends StatefulWidget

{
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CartItemDesign({
    this.model,
    this.context,
    this.quanNumber,
});

  @override
  _CartItemDesignState createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign>

{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(6.0,),
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(widget.model!.thumbnailUrl!, width: 140, height: 120,),

              const SizedBox(width: 6,),

              //title
              //quantity number
              //price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //title
                  Text(
                    widget.model!.title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: "Jost",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 1,),
                  //quantity number // x 7
                  Row(
                    children: [
                      const Text(
                        "x ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Jost",
                        ),
                      ),
                      Text(
                        widget.quanNumber.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Jost",
                        ),
                      ),
                    ],
                  ),

                  //price
                  Row(
                    children: [
                      const Text(
                        "Цена: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        "₽ ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.model!.price.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
