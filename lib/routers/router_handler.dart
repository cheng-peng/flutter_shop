import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';

Handler detailsHanlder = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String goodsId = params['id'].first;
  print('index>details goodsId is ${goodsId}');
  return DetailsPage(goodsId);
});
