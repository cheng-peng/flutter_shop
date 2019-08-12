import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routers{
  static String detailsPage='/detail';
  static void configureRoutes(Router router){
    router.notFoundHandler=Handler(
      handlerFunc: (BuildContext context,Map<String, List<String>> params){
        print('ERROR===>ROUTE WAS NOT FOUND!!!');
      }
    );

    router.define(detailsPage,handler: detailsHanlder);
  }
}