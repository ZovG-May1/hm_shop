import 'package:flutter/widgets.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("购物车"),
    );
  }
}