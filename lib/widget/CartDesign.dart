import 'package:flutter/material.dart';
import 'package:shop_cart_assignment/utils/constant.dart';

class CardDesign extends StatelessWidget {
  const CardDesign({
    super.key,
    required this.productName,
    required this.color,
    required this.size,
    required this.quantity,
    required this.price,
    required this.image,
    required this.increment,
    required this.decrement,
  });

  final String productName;
  final String color;
  final String size;
  final int quantity;
  final double price;
  final String image;
  final VoidCallback increment;
  final VoidCallback decrement;

  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    margin: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 5),
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildImageSection(),
          const SizedBox(width: 16),
          buildProductDetails(),
          buildTotalPrice(context), // Pass context here
        ],
      ),
    ),
  );

  Widget buildTotalPrice(BuildContext context) { // Accept context here
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            showDialog(
              context: context, // Use context here
              builder: (context) => AlertDialog(
                title: const Text('Options'),
                content: const Text('Choose an action'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Remove Item'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Save for Later'),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Text(
          '\$${(price * quantity).toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildProductDetails() {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.only(left: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style: TextStyle(
                color: mainTextColors,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Colors: ',
                        style: TextStyle(fontSize: 12, color: secondTextColor),
                      ),
                      TextSpan(
                        text: color,
                        style: TextStyle(fontSize: 12, color: mainTextColors),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Size: ',
                        style: TextStyle(fontSize: 12, color: secondTextColor),
                      ),
                      TextSpan(
                        text: size,
                        style: TextStyle(fontSize: 12, color: mainTextColors),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: greyColors,
                  radius: 15,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.remove,
                      size: 16,
                      color: mainTextColors,
                    ),
                    onPressed: quantity > 0 ? decrement : null,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  quantity.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: greyColors,
                  radius: 15,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.black,
                    ),
                    onPressed: increment,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageSection() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
        ),
      ),
    );
  }
}
