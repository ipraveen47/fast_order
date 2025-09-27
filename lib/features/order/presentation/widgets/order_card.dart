import 'package:fast_order/features/order/domain/entity/cart_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final CartItem order;
  final VoidCallback? onDelete;

  const OrderCard({super.key, required this.order, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/salad3.png', // Placeholder image
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Order name
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.delete_sweep, color: Colors.black),
                  onPressed: onDelete,
                ),
              ],
            ),

            const SizedBox(height: 5),

            // Quantity
            Text(
              "Quantity: ${order.quantity}",
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
