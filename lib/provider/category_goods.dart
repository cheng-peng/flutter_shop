import 'package:flutter/material.dart';
import '../model/categroy_goods.dart';

class CategoryGoodsProvider with ChangeNotifier {
  List<CategroyListData> goodsList = [];

//点击大类时更换商品列表
  getGoodsList(List<CategroyListData> list) {
    goodsList = list;
    notifyListeners();
  }

  getMoreList(List<CategroyListData> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}
