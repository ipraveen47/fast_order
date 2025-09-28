import 'package:fast_order/core/local_data/product.dart';
import 'package:fast_order/widget_support/widget_support.dart';
import 'package:flutter/material.dart';

class VerticalList extends StatelessWidget {
  final VoidCallback onTap;
  final Product product;
  const VerticalList({super.key, required this.onTap, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              minVerticalPadding: 0,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product.imagePath,
                  height: 55, // 👈 Reduced size to fit nicely
                  width: 55,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                product.title,
                style: AppWidget.semiBoldTextFeildStyle().copyWith(
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                product.subtitle,
                style: AppWidget.lightTextFeildStyle().copyWith(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                "\$${product.price}",
                style: AppWidget.semiBoldTextFeildStyle().copyWith(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
