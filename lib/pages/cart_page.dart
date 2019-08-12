import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];
  @override
  Widget build(BuildContext context) {

    _query();

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(700),
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(testList[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: (){_add();},
            child: Text('增加'),
          ),
           RaisedButton(
            onPressed: (){_delete();},
            child: Text('清空'),
          ),
        ],
      ),
    );
  }

  //增加方法
  void _add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = "CXP!!!";
    testList.add(temp);
    prefs.setStringList('testList', testList);
    _query();
  }

  //查询
  void _query() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('testList') != null) {
      setState(() {
        testList = prefs.getStringList('testList');
      });
    }
  }

  //删除
  void _delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //移除全部
    // prefs.clear();
    prefs.remove('testList');
    setState(() {
      testList.clear();
    });
  }
}
