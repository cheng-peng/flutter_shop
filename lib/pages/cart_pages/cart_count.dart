import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:flutter_shop/provider/cart.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  CartInfoModel item;

  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5),
      alignment: Alignment.centerLeft,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(context),
          _addBtn(context),
        ],
      ),
    );
  }

  //减号按钮
  Widget _reduceBtn(context) {
    return InkWell(
      onTap: () {
        if (item.count>1) {
          Provide.value<CartProvide>(context).addOrReduceAction(item, 'reduce');
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count>1?Colors.white:Colors.black12,
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: Text('-'),
      ),
    );
  }

  //加号按钮
  Widget _addBtn(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(context) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      child: Text('${item.count}'),
    );
  }
}
