import 'package:cloud_firestore/cloud_firestore.dart';

class Category
{
  String? categoryID;
  String? sellerUID;
  String? categoryTitle;
  String? categoryInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? status;

  Category({
    this.categoryID,
    this.sellerUID,
    this.categoryTitle,
    this.categoryInfo,
    this.publishedDate,
    this.thumbnailUrl,
    this.status,
  });

  Category.fromJson(Map<String, dynamic> json)
  {
    categoryID = json["categoryID"];
    sellerUID = json["sellerUID"];
    categoryTitle = json["categoryTitle"];
    categoryInfo = json["categoryInfo"];
    publishedDate = json["publishedDate"];
    thumbnailUrl = json["thumbnailUrl"];
    status = json["status"];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["categoryID"] = categoryID;
    data["sellerUID"] = sellerUID;
    data["categoryTitle"] = categoryTitle;
    data["categoryInfo"] = categoryInfo;
    data["publishedDate"] = publishedDate;
    data["thumbnailUrl"] = thumbnailUrl;
    data["status"] = status;

    return data;

  }
}