import 'package:fast_order/features/order/presentation/bloc/order_bloc.dart';
import 'package:fast_order/features/order/presentation/widgets/order_card.dart';
import 'package:fast_order/features/order/presentation/widgets/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    // Fetch cart items when the page initializes
    context.read<OrderBloc>().add(GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Your Cart',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.shopping_cart_outlined, color: Colors.black),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listenWhen: (previous, current) {
          // Only listen when messages actually change
          return previous.successMessage != current.successMessage ||
              previous.errorMessage != current.errorMessage ||
              previous.placeOrderMessage != current.placeOrderMessage;
        },
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.successMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.successMessage!)));
          }

          if (state.placeOrderMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.placeOrderMessage!)));
          }
        },
        builder: (context, state) {
          final cartItems = state.cartItems;

          if (state.isLoading && cartItems.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          // Calculate total price
          final total = cartItems.fold<double>(
            0,
            (sum, item) => sum + item.totalPrice,
          );

          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return OrderCard(
                        order: cartItem,
                        onDelete: () {
                          // context.read<OrderBloc>().add(DeleteCartItemEvent(cartItem: cartItem));
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (_) => PaymentBottomSheet(
                            onPaymentSelected: (paymentMethod) {
                              context.read<OrderBloc>().add(
                                PlaceOrderEvent(cartItem: cartItems),
                              );
                            },
                          ),
                        );
                      },
                      child: state.isPlacingOrder
                          ? Container(
                              width: 150,
                              height: 48,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : Container(
                              width: 150,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Place Order",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
