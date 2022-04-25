import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:olkdelivery_users_app/models/sellers.dart';
import 'package:olkdelivery_users_app/widgets/category_design.dart';
import '../assistantMethods/assistant_methods.dart';
import '../models/category.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';

class CategoryScreen extends StatefulWidget

{
  final Sellers? model;
  CategoryScreen({this.model});


  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.lightGreen,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: ()
          {
            clearCartNow(context);

            Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
          },
        ),
        automaticallyImplyLeading: true,
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Jost",
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan> [
              TextSpan(text: "Нужные", style: TextStyle(color: Colors.white),),
              TextSpan(text: " Люди", style: TextStyle(color: Colors.yellow),),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.sellerName.toString() + "")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("category")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                child: Center(child: circularProgress(),),
              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Category model = Category.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return CategoryDesignWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
