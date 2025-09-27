import 'package:fast_order/features/order/presentation/bloc/order_bloc.dart';
import 'package:fast_order/features/order/presentation/widgets/placed_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    // Fetch placed orders when the page initializes
    context.read<OrderBloc>().add(GetPlacedOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // ✅ Center title contents
          mainAxisSize:
              MainAxisSize.min, // ✅ Prevent Row from taking full width
          children: const [
            Text(
              'Your Orders',
              style: TextStyle(
                color: Colors.black, // Title text color
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 10), // Small spacing between text and icon
            Icon(
              Icons.shopping_cart_outlined,
              color:
                  Colors.black, // Make sure icon is visible on white background
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, // ✅ Make back button/icon black
        ),
        elevation: 0,
      ),

      body: SafeArea(
        child: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is GetPlacedOrdersFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetPlacedOrdersSuccess) {
              final orders = state.placedOrders;

              if (orders.isEmpty) {
                return const Center(child: Text('No orders found'));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final itemCount = order.cartItems.length;

                    return state.isLoading
                        ? CircularProgressIndicator()
                        : PlacesOrderCard(
                            itemCount: itemCount,
                            totalPrice: order.totalAmount,
                            status: order.status,
                            onTap: () {},
                          );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
