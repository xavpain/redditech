import 'package:flutter/material.dart';
import 'package:redditech/UI/custom_appBar.dart';
import 'UI/custom_appBar.dart';

class ItemModel {
  bool expanded;
  String headerItem;
  String discription;
  Color colorsItem;
  String img;

  ItemModel(
      {this.expanded: false,
      required this.headerItem,
      required this.discription,
      required this.colorsItem,
      required this.img});
}
