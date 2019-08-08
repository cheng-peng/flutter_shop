import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {

  TextEditingController typeController = TextEditingController();

  String showText = '欢迎您来到美好人间高级会所';

  @override
  Widget build(BuildContext context) {
   return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美好人间'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '美女类型',
                  helperText: '请输入你喜欢的类型',
                ),
                //取消默认获取焦点
                autofocus: false,
              ),
              RaisedButton(
                onPressed: _choiceAction,
                child: Text('选择完毕'),
              ),
              Text(
                showText,
                //文字过长显示省略号
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _choiceAction() {
    print('开始选择你喜欢的类型.......');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text('美女类型不能为空')));
    } else {
      getHttp(typeController.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  //Future 可以使用then然后val等于这个返回值
  Future getHttp(String typeText) async {
    try {
      var data = {'name': typeText};
      Response response = await Dio().get(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
          queryParameters: data);

      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
