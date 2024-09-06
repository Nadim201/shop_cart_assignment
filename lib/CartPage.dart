import 'package:flutter/material.dart';
import 'package:shop_cart_assignment/utils/constant.dart';
import 'package:shop_cart_assignment/widget/CartDesign.dart';
import 'package:shop_cart_assignment/utils/cartMap.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void itemIncrement(int index) {
    setState(() {
      cartItem[index]['quantity']++;
    });
  }

  void itemDecrement(int index) {
    setState(
      () {
        if (cartItem[index]['quantity'] > 0) {
          cartItem[index]['quantity']--;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Bag',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: defaultPadding),
          buildListView(),
          buildTotalItem(context)
        ],
      ),
    );
  }

  Widget buildListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: cartItem.length,
        itemBuilder: (context, index) {
          var item = cartItem[index];
          return CardDesign(
            productName: item['title'],
            color: item['color'],
            size: item['size'],
            quantity: item['quantity'],
            price: item['price'],
            image: item['image'],
            increment: () => itemIncrement(index),
            decrement: () => itemDecrement(index),
          );
        },
      ),
    );
  }

  Widget buildTotalItem(BuildContext context) {
    double totalAmount = 0;
    for (var item in cartItem) {
      totalAmount += item['quantity'] * item['price'];
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Amount:',
                  style: TextStyle(fontSize: 14, color: secondTextColor)),
              Text('\$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: redColors, foregroundColor: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Congratulations! Checkout Successful!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Check Out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
