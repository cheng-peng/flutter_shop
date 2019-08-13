import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cart = "[]";
  List<CartInfoModel> cartList = [];
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //商品总数量
  bool isAllCheck = true; //是否全选

  //加入购物车
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart = prefs.getString('cartInfo');
    var temp = cart == null ? [] : json.decode(cart);
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    allPrice=0;
    allGoodsCount=0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      if (item['isCheck']) {
        allPrice+=(cartList[ival].price*cartList[ival].count);
        allGoodsCount+=cartList[ival].count;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };

      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));

      allPrice+=count*price;
      allGoodsCount+=count;
    }

    cart = json.encode(tempList).toString();
    print(cart);
    prefs.setString('cartInfo', cart);
    notifyListeners();
  }

  //清空购物车
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList.clear();
    print('清空完成.............');
    notifyListeners();
  }

  //查询购物车
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart = prefs.getString('cartInfo');
    cartList = [];
    if (cart == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cart) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += item['count'] * item['price'];
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  //删除购物车单个商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cart) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(delIndex);
    cart = json.encode(tempList).toString();
    prefs.setString('cartInfo', cart);
    await getCartInfo();
  }

  //选中状态改变
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cart) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    //dart 不能在循环时修改数据
    tempList[changeIndex] = cartItem.toJson();
    cart = json.encode(tempList).toString();
    prefs.setString('cartInfo', cart);
    await getCartInfo();
  }

  //点击全选按钮操作
  changeAllCheck(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cart) as List).cast();
    List<Map> newList = [];

    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cart = json.encode(newList).toString();
    prefs.setString('cartInfo', cart);
    await getCartInfo();
  }

  //商品数量加减
  addOrReduceAction(CartInfoModel cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cart) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cart = json.encode(tempList).toString();
    prefs.setString('cartInfo', cart);
    await getCartInfo();
  }
}
