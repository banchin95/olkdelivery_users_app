import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:olkdelivery_users_app/assistantMethods/assistant_methods.dart';
import 'package:olkdelivery_users_app/authentication/login.dart';
import 'package:olkdelivery_users_app/models/sellers.dart';
import 'package:olkdelivery_users_app/splashScreen/splash_screen.dart';
import 'package:olkdelivery_users_app/widgets/sellers_design.dart';
import 'package:olkdelivery_users_app/widgets/my_drawer.dart';
import 'package:olkdelivery_users_app/widgets/progress_bar.dart';
import '../global/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  final items = [
    "slider/0.jpeg",
    "slider/1.jpeg",
    "slider/2.jpeg",
  ];

  RestrictBlockedUsersFromUsingApp() async
  {
    await FirebaseFirestore.instance.collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get().then((snapshot)
    {
      if(snapshot.data()!["status"] != "approved")
      {
        Fluttertoast.showToast(msg: "Вы были заблокированы.");

        firebaseAuth.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
      }
      else
      {
        clearCartNow(context);
      }
    });
  }

  @override
  void initState()
  {
    super.initState();

    RestrictBlockedUsersFromUsingApp();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.lightGreen,
          ),
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
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * .3,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 8),
                    autoPlayAnimationDuration: const Duration(milliseconds: 900),
                    autoPlayCurve: Curves.decelerate,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: items.map((index) {
                    return Builder(builder: (BuildContext context){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        // decoration: const BoxDecoration(
                        //   color: Colors.black,
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                              index,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    });
                  }).toList()
                ),
              ),

            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c)=> const StaggeredTile.fit(1),
                      itemBuilder: (context, index)
                      {
                        Sellers sModel = Sellers.fromJson(
                          snapshot.data!.docs[index].data()! as Map<String,dynamic>
                        );
                        //дизайн экран магазинов
                        return SellersDesignWidget(
                            model: sModel,
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
