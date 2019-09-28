import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_main_page.dart';
import 'package:flutter_app/pages/browser.dart';
import 'package:flutter_app/pages/more_recommended_page.dart';

//配置路由
final routes = {
  '/home':(context) => HomeMainPage(),
  '/browser':(context,{arguments}) => Browser(arguments),
  '/more':(context) => MoreRecommendedProject(),
  //'/product_detaile':(context,{arguments}) => ProductDetailePage(arguments: arguments),
};

//配置路由传值
// ignore: strong_mode_top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings){
  print("进入路由拦截器");
  final String name = settings.name;
  print(name);
  final Function pageContentBuilder = routes[name];
  if(pageContentBuilder != null){
    if(settings.arguments != null){
      final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context,arguments:settings.arguments)
      );
      return route;
    }else{
      final Route route = MaterialPageRoute(
          builder:(context) =>
          pageContentBuilder(context)
      );
      return route;
    }
  }
};