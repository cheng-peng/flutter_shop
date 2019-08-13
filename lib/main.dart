import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/cart.dart';
import 'package:flutter_shop/provider/current_index.dart';
import 'package:flutter_shop/provider/details_info.dart';
import './pages/index_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provide/provide.dart';
import './provider/counter.dart';
import './provider/child_category.dart';
import './provider/category_goods.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categoryGoods = CategoryGoodsProvider();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();

  //.. 用该对象并返回该对象
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsProvider>.value(categoryGoods))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: "百姓生活",
        onGenerateRoute: Application.router.generator,
        //隐藏右上角debug
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
