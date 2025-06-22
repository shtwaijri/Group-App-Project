import 'package:essert_coffee/style/style_color.dart';
import 'package:flutter/material.dart';

class CustumOrder extends StatelessWidget {
  const CustumOrder({
    super.key,
    required this.img,
    required this.title,
    required this.price,
    required this.quantity,
    required this.increaseQuantity,
    required this.decreaseQuantity,
    required this.removeItem,
  });
  final Image img;
  final String title;
  final double price;
  final int quantity;

  final void Function()? increaseQuantity;
  final void Function()? decreaseQuantity;
  final void Function()? removeItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 350,
      decoration: BoxDecoration(
        color: StyleColor.floralWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // spacing: 4,
          children: [
            // SizedBox(width: 0),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 240, 232),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: img),
            ),
            // VerticalDivider(color: Colors.black, thickness: 1),
            Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(title), Text('${price * quantity} SAR')],
            ),
            IconButton(onPressed: increaseQuantity, icon: Icon(Icons.add)),
            Text('${quantity}'),
            IconButton(
              onPressed: decreaseQuantity,
              icon: Icon(
                Icons.remove,
                color: quantity <= 1 ? Colors.grey : Colors.black,
              ),
            ),
            IconButton(
              splashColor: Color.fromARGB(0, 255, 0, 0),
              hoverColor: Color.fromARGB(0, 255, 0, 0),
              highlightColor: Color.fromARGB(0, 255, 0, 0),
              onPressed: removeItem,
              icon: Icon(Icons.delete_outline),
            ),
            // SizedBox(width: 0),
          ],
        ),
      ),
    );
  }
}
