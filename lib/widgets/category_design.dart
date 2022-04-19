import 'package:flutter/material.dart';
import 'package:olkdelivery_users_app/mainScreen/items_screen.dart';
import 'package:olkdelivery_users_app/models/category.dart';


class CategoryDesignWidget extends StatefulWidget
{
  Category? model;
  BuildContext? context;

  CategoryDesignWidget({this.model, this.context});

  @override
  _CategoryDesignWidgetState createState() => _CategoryDesignWidgetState();
}



class _CategoryDesignWidgetState extends State<CategoryDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 280,
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
                widget.model!.categoryTitle!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Jost",
                ),
              ),
              Text(
                widget.model!.categoryInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
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
