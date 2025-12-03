import 'package:flutter/widgets.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("分类"),
    );
  }
}