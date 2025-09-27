import 'package:flutter/material.dart';

typedef PaymentCallback = void Function(String paymentMethod);

class PaymentBottomSheet extends StatelessWidget {
  final PaymentCallback onPaymentSelected;

  const PaymentBottomSheet({super.key, required this.onPaymentSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // adjusts height to content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Payment Method',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Payment Options
          _buildOption(
            context,
            'UPI',
            Icons.account_balance_wallet,
            Colors.green,
          ),
          _buildOption(context, 'Credit Card', Icons.credit_card, Colors.blue),
          _buildOption(context, 'Debit Card', Icons.payment, Colors.orange),

          const SizedBox(height: 10),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color, size: 30),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      onTap: () {
        Navigator.pop(context);
        onPaymentSelected(title); // callback with selected payment method
      },
    );
  }
}
