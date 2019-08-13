import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> chidCategroyList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '4'; //大类Id，默认白酒
  String subId = ''; //小类Id
  int page = 1; //列表页数
  String noMoreText = ''; //显示没有数据的文字
  int categoryIndex = 0; //大类索引

//大类切换逻辑
  getChildCategory(List<BxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';
    childIndex = 0;
    categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '4';
    all.comments = 'null';
    all.mallSubName = '全部';
    chidCategroyList = [all];
    chidCategroyList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(int index, String id) {
    page = 1;
    noMoreText = '';
    subId = id;
    childIndex = index;
    notifyListeners();
  }

  //增加Page的方法
  addPage() {
    page++;
  }

  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }

  //首页点击类别是更改类别
  changeCategory(String id, int index) {
    categoryId = id;
    categoryIndex = index;
    subId = '';
    notifyListeners();
  }
}
