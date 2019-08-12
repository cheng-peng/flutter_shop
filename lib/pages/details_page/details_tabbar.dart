import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provider/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var isFlag = Provide.value<DetailsInfoProvide>(context).isFlag;

        return Container(
          margin: EdgeInsets.only(top: 15),
          child: Row(
            children: <Widget>[
              _myTabBarLeft(context, isFlag),
              _myTabBarRight(context, isFlag)
            ],
          ),
        );
      },
    );
  }

//左侧按钮
  Widget _myTabBarLeft(BuildContext context, bool isFlag) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight(true);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isFlag ? Colors.pink : Colors.black12))),
        child: Text(
          '详情',
          style: TextStyle(color: isFlag ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

//右侧按钮
  Widget _myTabBarRight(BuildContext context, bool isFlag) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight(false);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isFlag ? Colors.black12 : Colors.pink))),
        child: Text(
          '评论',
          style: TextStyle(color: isFlag ? Colors.black : Colors.pink),
        ),
      ),
    );
  }
}
