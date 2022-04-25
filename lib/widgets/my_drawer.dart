import 'package:flutter/material.dart';
import 'package:olkdelivery_users_app/global/global.dart';
import 'package:olkdelivery_users_app/mainScreen/address_screen.dart';
import 'package:olkdelivery_users_app/mainScreen/history_screen.dart';
import 'package:olkdelivery_users_app/mainScreen/home_screen.dart';
import 'package:olkdelivery_users_app/mainScreen/my_orders_screen.dart';
import 'package:olkdelivery_users_app/mainScreen/search_screen.dart';

import '../authentication/auth_screen.dart';

class MyDrawer extends StatelessWidget
{


  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      backgroundColor: Colors.green,
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                    sharedPreferences!.getString("name")!,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Jost", fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12,),

          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0, left: 10),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white, size: 30,),
                  title: const Text(
                    "Главная",
                    style: TextStyle(color: Colors.white, fontFamily: "Jost", fontSize: 20),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.white, size: 30,),
                  title: const Text(
                    "Мои заказы",
                    style: TextStyle(color: Colors.white, fontFamily: "Jost", fontSize: 20),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> MyOrdersScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history, color: Colors.white, size: 30,),
                  title: const Text(
                    "История",
                    style: TextStyle(color: Colors.white, fontFamily: "Jost", fontSize: 20),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search, color: Colors.white, size: 30,),
                  title: const Text(
                    "Поиск",
                    style: TextStyle(color: Colors.white, fontFamily: "Jost", fontSize: 20),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> SearchScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_location, color: Colors.white, size: 30,),
                  title: const Text(
                    "Добавить новый адрес",
                    style: TextStyle(color: Colors.white, fontFamily: "Jost", fontSize: 20),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> AddressScreen()));
                  },
                ),
                const SizedBox(height: 50,),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                const SizedBox(height: 80,),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.white, size: 30,),
                  title: const Text(
                    "Выйти",
                    style: TextStyle(color: Colors.white, fontFamily: "Jost", fontSize: 20),
                  ),
                  onTap: ()
                  {
                    firebaseAuth.signOut().then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
