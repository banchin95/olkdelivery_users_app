import 'package:flutter/material.dart';
import 'package:olkdelivery_users_app/mainScreen/item_detail_screen.dart';
import 'package:olkdelivery_users_app/models/items.dart';
import 'package:olkdelivery_users_app/models/sellers.dart';


class ItemsDesignWidget extends StatefulWidget
{
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}



class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          margin: EdgeInsets.only(bottom: 0),
          height: 310,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 220.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1.0,),
              Text(
                widget.model!.title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Jost",
                ),
              ),
              const SizedBox(height: 2.0,),
              Text(
                widget.model!.shortInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2.0,),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
