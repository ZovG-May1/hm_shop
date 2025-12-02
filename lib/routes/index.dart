//管理路由
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';

//返回App根级组件
Widget getRootWidget() {
  return MaterialApp(
    //命名路由
    initialRoute: "/mainPage",
    routes: getRootRoutes(),
  );
}

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    "/mainPage": (context) => MainPage(),
    "/login": (context) => LoginPage(),
  };
}