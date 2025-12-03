import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/cart.dart';
import 'package:hm_shop/pages/Home/home.dart';
import 'package:hm_shop/pages/My/my.dart';
import 'package:hm_shop/pages/category/category.dart';

//主界面配置
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //设置图片链表
  final List<Map<String, String>> _listIcon = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      //"icon": "lib/assets/ic_public_home_normal_gif.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
      "text": "主页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "text": "我的",
    },
  ];
  //设置底部图标选中索引
  int _currentIndex = 0;

  //得到主干部分组件
  Widget _getBody() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text("主页界面", style: TextStyle(color: Colors.white, fontSize: 70),),
    );
  }
  Widget _getIndexStackBody(String text) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 70),),
    );
  }
  List<Widget> _getIndexStack() {
    return [HomeView(), CategoryView(), CartView(), MyView()];
  }

  //得到底部标题栏
  List<BottomNavigationBarItem> _getbottomItem() {
    return List.generate(_listIcon.length, (int index) {
      return BottomNavigationBarItem(
        //正常显示图标
        icon: Image.asset(_listIcon[index]["icon"]!, width: 20, height: 20,),
        //激活时显示的图标
        activeIcon: Image.asset(_listIcon[index]["active_icon"]!, width: 20, height: 20,),
        label: _listIcon[index]["text"],
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("主页"),
      ),
      //body: _getBody(), //传统写法
      //SafeArea避开安全区组件(自己的写法)
      // body: SafeArea(
      //   child: IndexedStack(
      //     index: _currentIndex,
      //     children: List.generate(_listIcon.length, (index) {
      //       //int indexFlag = (index + _currentIndex >= _listIcon.length) ? (index + _currentIndex - _listIcon.length) : index + _currentIndex;
      //       return _getIndexStackBody(_listIcon[index]["text"]!);
      //     }),
      //   ),
      // ),
      //教学视频的写法
      body:SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _getIndexStack(),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        //点击事件
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
        //状态栏中的逐个图标
        items: _getbottomItem(),
        //设置初始化的选中图标
        currentIndex: _currentIndex,
        //设置当前选中的图标的label的颜色
        selectedItemColor: Colors.black,
        //设置显示所有图标的label
        showUnselectedLabels: true,
        //设置未选中的图标的label的颜色
        unselectedItemColor: Colors.black,
      ),
    );
  }
}