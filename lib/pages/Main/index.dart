import 'package:flutter/material.dart';

//主界面配置
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("主页", style: TextStyle(color: Colors.white, fontSize: 40),),
          ),
        ],
      ),
    );
  }
}