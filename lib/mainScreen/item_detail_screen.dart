import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:olkdelivery_users_app/widgets/app_bar.dart';
import '../assistantMethods/assistant_methods.dart';
import '../models/items.dart';

class ItemDetailsScreen extends StatefulWidget
{
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen>
{

  TextEditingController counterTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.width - 40,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.model!.thumbnailUrl.toString(),
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                widget.model!.price.toString() + " ₽",
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 30, left: 30, bottom: 30),
              child: NumberInputPrefabbed.roundedButtons(
                controller: counterTextEditingController,
                incDecBgColor: Colors.lightGreen,
                min: 1,
                max: 99,
                initialValue: 1,
                buttonArrangement: ButtonArrangement.incRightDecLeft,
                incIcon: Icons.add,
                decIcon: Icons.remove,
                incIconSize: 40,
                decIconSize: 40,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 10,),
              child: Text(
                widget.model!.title.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14,),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: InkWell(
              onTap: ()
              {
                int itemCounter = int.parse(counterTextEditingController.text);

                List<String> separateItemIDsList = separateItemIDs();

                //1. check if item exist already in cart
                separateItemIDsList.contains(widget.model!.itemID)
                    ? Fluttertoast.showToast(msg: "Товар уже в корзине.")
                    :
                    //2. add to cart

                addItemToCart(widget.model!.itemID, context, itemCounter);
              },
              child: Container(
                margin: EdgeInsets.only(right: 30, left: 30, top: 30, bottom: 30),
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                child: const Center(
                  child: Text(
                    "В Корзину",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}