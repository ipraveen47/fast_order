import 'package:fast_order/core/local_data/product.dart';
import 'package:flutter/material.dart';
import 'package:fast_order/widget_support/widget_support.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width:
                180, // <-- IMPORTANT: add fixed width for horizontal ListView
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    product.imagePath,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5),
                Text(product.title, style: AppWidget.semiBoldTextFeildStyle()),
                Text(product.subtitle, style: AppWidget.lightTextFeildStyle()),
                const SizedBox(height: 5),
                Text(
                  "\$${product.price}",
                  style: AppWidget.semiBoldTextFeildStyle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
