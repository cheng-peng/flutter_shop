import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import '../../provider/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var goodsInfo =
            Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice),
              ],
            ),
          );
        } else {
          return Text('正在加载中......');
        }
      },
    );
  }

//商品图片
  Widget _goodsImage(String url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  //商品名称
  Widget _goodsName(String name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

//商品编号
  Widget _goodsNum(String num) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号：${num}',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(double price, double price1) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Text(
            '￥ ${price}',
            style: TextStyle(color: Colors.pink),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              '市场价：',
              style: TextStyle(color: Colors.black26),
            ),
          ),
          Text(
            '${price1}',
            style: TextStyle(
                color: Colors.black12, decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
