import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cached_network_image/cached_network_image.dart';


// product_model.dart
class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

// 模拟从网络API获取热门商品列表
Future<List<Product>> fetchHotProducts() async {
  // 模拟网络延迟
  await Future.delayed(const Duration(seconds: 2));

  // 在实际应用中，这里会是一个真实的HTTP请求，例如：
  // final response = await http.get(Uri.parse('https://your-api.com/hot-products'));
  // final data = jsonDecode(response.body);
  // return (data as List).map((json) => Product.fromJson(json)).toList();

  // 模拟返回的数据
  return [
    Product(
      id: '1',
      name: '高端无线耳机',
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      price: 299.99,
    ),
    Product(
      id: '2',
      name: '智能手表',
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      price: 199.50,
    ),
    Product(
      id: '3',
      name: '便携式相机',
      imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      price: 499.00,
    ),
    Product(
      id: '4',
      name: '游戏手柄',
      imageUrl: 'https://images.unsplash.com/photo-1587814213271-7a6625b76c33?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      price: 59.99,
    ),
    Product(
      id: '5',
      name: '蓝牙音箱',
      imageUrl: 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      price: 89.99,
    ),
    Product(
      id: '6',
      name: '机械键盘',
      imageUrl: 'https://images.unsplash.com/photo-1541140532154-b024d705b90a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      price: 129.99,
    ),
  ];
}



class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //在这里实现主页的内容，骨架由上到下包括轮播图、横向滑动的分类列表、特惠推荐、爆款推荐
  Widget _getHome() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _Slideshow(),),
        SliverToBoxAdapter(child: SizedBox(height: 10,)),
        SliverToBoxAdapter(child: _listWidget(),),
        SliverToBoxAdapter(child: SizedBox(height: 10,),),
        SliverToBoxAdapter(child: _SuggestionWidget(),),
        SliverToBoxAdapter(child: SizedBox(height: 10,),),
        SliverToBoxAdapter(child: _HotWidget(),),
        SliverToBoxAdapter(child: SizedBox(height: 10,),),
        _MoreWidget(),
        //SliverToBoxAdapter(child: _MoreWidget(),),
    ],);

    //return _MoreWidget();
  }
  
  @override
  Widget build(BuildContext context) {
    return _getHome();
  }
}

//轮播图类
class _Slideshow extends StatefulWidget {
  const _Slideshow({super.key});

  @override
  __SlideshowState createState() => __SlideshowState();
}

class __SlideshowState extends State<_Slideshow> {
  PageController? _pageControl; //轮播图控制器
  int _pageIndex = 0;
  // Future用于保存我们的网络请求
  late final Future<List<Product>> _hotProductsFuture;

  @override
  void initState() {
    super.initState();
    _pageControl = PageController();
    // 在初始化状态时调用API
    _hotProductsFuture = fetchHotProducts();
  }

  @override
  void dispose() {
    _pageControl!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //带导向的轮播图
    // return Stack(
    //   children: [
    //     //轮播图主体
    //     Container(
    //       height: 200,
    //       decoration: BoxDecoration(color: Colors.blue),
    //       //bulider，懒加载
    //       child: PageView.builder(
    //         controller: _pageControl,
    //         itemCount: 6,
    //         //physics: BouncingScrollPhysics(),
    //         itemBuilder: (BuildContext context, int index) {
    //           return Container(
    //             alignment: Alignment.center,
    //             child: Text("轮播图${index + 1}"),
    //           );
    //       }),
    //     ),

    //     //跳转选项
    //     Positioned(
    //       bottom: 0,
    //       right: 0,
    //       left: 0,
    //       child: Container(
    //         height: 40,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: List.generate(6, (index) {
    //             return GestureDetector(
    //               onTap: () {
    //                 _pageIndex = index;
    //                 //_pageControl!.jumpToPage(index);
    //                 _pageControl!.animateToPage(index, duration: Duration(seconds: 2), curve: Curves.linear); //动画跳转，跳转时间两秒，跳转路径曲线为直线
    //                 setState(() {});
    //               },
    //               child: Container(
    //                 height: 10,
    //                 width: 10,
    //                 margin: EdgeInsets.only(right: 10),
    //                 decoration: BoxDecoration(
    //                   color: _pageIndex == index ? Colors.red : Colors.white,
    //                   borderRadius: BorderRadius.circular(5),
    //                 ),
    //               ),
    //             );
    //           }),
    //         ),
    //       ),
    //     ),
    // ],);


      //文心一言的方法
      return Container(
        height: 300,
        // 使用FutureBuilder来处理异步数据
        child: FutureBuilder<List<Product>>(
          future: _hotProductsFuture,
          builder: (context, snapshot) {
            // 1. 检查数据是否加载完成
            if (snapshot.connectionState == ConnectionState.done) {
              // 2. 如果数据加载成功且没有错误
              if (snapshot.hasData && snapshot.data != null) {
                final products = snapshot.data!;
                // 3. 如果数据列表不为空，构建PageView
                if (products.isNotEmpty) {
                  return PageView.builder(
                    controller: _pageControl,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return buildProductCarouselItem(product);
                    },
                  );
                } else {
                  // 数据为空的情况
                  return const Text('暂无商品数据');
                }
              } else if (snapshot.hasError) {
                // 4. 如果有错误，显示错误信息
                return Text('加载失败: ${snapshot.error}');
              } else {
                // 5. 其他情况（例如没有数据）
                return const Text('暂无数据');
              }
            } else {
              // 6. 数据还在加载中，显示加载指示器
              return const CircularProgressIndicator();
            }
          },
        ),
      );

  }

// 构建单个轮播图商品项的Widget
  Widget buildProductCarouselItem(Product product) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 使用CachedNetworkImage可以更好地处理图片缓存和加载状态
            CachedNetworkImage(
              imageUrl: product.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            // 半透明遮罩，让文字更清晰
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                ),
              ),
            ),
            // 商品信息
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '¥${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.red.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//横向滑动列表
class _listWidget extends StatefulWidget {
  const _listWidget({super.key});

  @override
  __listWidgetState createState() => __listWidgetState();
}

class __listWidgetState extends State<_listWidget> {
  List<String> _listGoodsCategory = ["女装", "男装", "鞋包", "数码", "百货", "食品", "内衣", "电器", "家具", "美妆", "药瓶", "文具", "工具", "运动", "眼睛", "帽子", "书本",];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _listGoodsCategory.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(_listGoodsCategory[index], style: TextStyle(color: Colors.black, fontSize: 20),),
          );
        }
      ),
    );
  }
}

//推荐
class _SuggestionWidget extends StatefulWidget {
  _SuggestionWidget({Key? key}) : super(key: key);

  @override
  __SuggestionWidgetState createState() => __SuggestionWidgetState();
}

class __SuggestionWidgetState extends State<_SuggestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      color: Colors.blue,
       child: Text("推荐", style: TextStyle(color: Colors.white, fontSize: 30),),
    );
  }
}

//爆款
class _HotWidget extends StatefulWidget {
  _HotWidget({Key? key}) : super(key: key);

  @override
  __HotWidgetState createState() => __HotWidgetState();
}

class __HotWidgetState extends State<_HotWidget> {
  @override
  Widget build(BuildContext context) {
    //爆款推荐，要求是两个相同的组件（也就是完全均分的，我的想法是采用网格滚动组件）
    // return SizedBox(
    //   height: 180,
    //   child: GridView.builder(
    //     itemCount: 2,
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //     ), 
    //     itemBuilder: (BuildContext context, int index) {
    //       return Container(
    //         margin: EdgeInsets.symmetric(horizontal: 10),
    //         alignment: Alignment.center,
    //         color: Colors.blue,
    //         child: Text("爆款$index", style: TextStyle(color: Colors.white),),
    //       );
    //     }),
    // );

    //视频教学的方法，用 FLex 均分组件
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Container(
            height: 260,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text("爆款", style: TextStyle(color: Colors.white),),
        )),
        SizedBox(width: 10,),
        Expanded(
          flex: 2,
          child: Container(
            height: 260,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text("爆款", style: TextStyle(color: Colors.white),),          
        )),
    ],);
  }
}

//无限滚动的商品
class _MoreWidget extends StatefulWidget {
  _MoreWidget({Key? key}) : super(key: key);

  @override
  __MoreWidgetState createState() => __MoreWidgetState();
}

class __MoreWidgetState extends State<_MoreWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 260,
      ), 
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 100,
          //padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(2),
          color: Colors.blue,
          child: Text("商品${index + 1}", style: TextStyle(color: Colors.white, fontSize: 20),),
        );
      });

    // return GridView.builder(
    //     itemCount: 100,
    //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 200,
    //     ), 
    //   itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //       height: 100,
    //       color: Colors.blue,
    //       child: Text("商品${index + 1}", style: TextStyle(color: Colors.white, fontSize: 20),),
    //     );
    //   });
  }
}