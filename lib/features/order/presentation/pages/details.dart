import 'package:fast_order/core/local_data/product.dart';
import 'package:fast_order/features/order/domain/entity/cart_model.dart';
import 'package:fast_order/features/order/presentation/bloc/order_bloc.dart';
import 'package:fast_order/widget_support/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Details extends StatefulWidget {
  final Product products; // passed from HomePage

  const Details({super.key, required this.products});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.products; // shorthand for easier access

    return Scaffold(
      body: BlocConsumer<OrderBloc, OrderState>(
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

            setState(() {
              quantity = 1; // reset quantity
            });
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Product Image
                        Image.asset(
                          product.imagePath,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.5,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(height: 15),

                        // Title & Subtitle with quantity controls
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: AppWidget.semiBoldTextFeildStyle(),
                                ),
                                Text(
                                  product.subtitle,
                                  style: AppWidget.boldTextFeildStyle(),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Decrease quantity
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) quantity--;
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              quantity.toString(),
                              style: AppWidget.semiBoldTextFeildStyle(),
                            ),
                            const SizedBox(width: 20),
                            // Increase quantity
                            GestureDetector(
                              onTap: () {
                                quantity++;
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Description
                        Text(
                          product.description,
                          style: AppWidget.lightTextFeildStyle(),
                        ),
                        const SizedBox(height: 30),

                        // Delivery Time
                        Row(
                          children: [
                            Text(
                              "Delivery Time",
                              style: AppWidget.semiBoldTextFeildStyle(),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.alarm, color: Colors.black54),
                            const SizedBox(width: 5),
                            Text(
                              product.deliveryTime,
                              style: AppWidget.semiBoldTextFeildStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Add to Cart Bar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price",
                          style: AppWidget.semiBoldTextFeildStyle(),
                        ),
                        Text(
                          "\$${product.price * quantity}",
                          style: AppWidget.headlineTextFeildStyle(),
                        ),
                      ],
                    ),
                    // Add to Cart Button
                    state.isLoading
                        ? Container(
                            width: MediaQuery.of(context).size.width / 2,
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
                        : GestureDetector(
                            onTap: state.isLoading
                                ? null
                                : () {
                                    final cartItem = CartItem(
                                      totalPrice: product.price * quantity,
                                      productName: product.title,
                                      quantity: quantity,
                                    );
                                    // firing the add to cart event
                                    context.read<OrderBloc>().add(
                                      AddToCartEvent(cartItem: cartItem),
                                    );
                                  },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Add to cart",
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
              ),
            ],
          );
        },
      ),
    );
  }
}
