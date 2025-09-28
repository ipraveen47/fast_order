import 'package:fast_order/core/local_data/product.dart';
import 'package:fast_order/features/order/presentation/pages/details.dart';
import 'package:fast_order/features/order/presentation/widgets/product_card.dart';
import 'package:fast_order/features/order/presentation/widgets/vertical_list.dart';
import 'package:fast_order/widget_support/widget_support.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool icecream = false, pizza = false, salad = false, burger = false;

  final List<Product> products = [
    Product(
      imagePath: "assets/salad2.png",
      title: "Veggie Taco Hash",
      subtitle: "Fresh and Healthy",
      price: 25.0,
      description:
          "A delicious mix of fresh veggies and taco spices. Perfect for a healthy meal.",
      deliveryTime: "30 min",
      id: '',
    ),
    Product(
      imagePath: "assets/salad4.png",
      title: "Mix Veg Salad",
      subtitle: "Spicy with Onion",
      price: 28.0,
      description:
          "Fresh mix vegetable salad with a spicy onion dressing, served chilled.",
      deliveryTime: "20 min",
      id: '',
    ),
    Product(
      imagePath: "assets/drink.png",
      title: "Cold Coffee",
      subtitle: "With Ice Cream",
      price: 20.0,
      description:
          "Refreshing cold coffee topped with vanilla ice cream for a perfect treat.",
      deliveryTime: "10 min",
      id: '',
    ),
    Product(
      imagePath: "assets/fries.png",
      title: "French Fries",
      subtitle: "Crispy & Golden",
      price: 15.0,
      description: "Crispy golden fries served hot with tangy tomato ketchup.",
      deliveryTime: "8 min",
      id: '',
    ),
    Product(
      imagePath: "assets/smoothie.",
      title: "Berry Smoothie",
      subtitle: "Fresh & Chilled",
      price: 22.0,
      description:
          "A refreshing blend of strawberries, blueberries, and yogurt for a healthy drink.",
      deliveryTime: "12 min",
      id: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello User,", style: AppWidget.boldTextFeildStyle()),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text("Delicious Food", style: AppWidget.headlineTextFeildStyle()),
              Text(
                "Fast Order Serving",
                style: AppWidget.lightTextFeildStyle(),
              ),

              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: showItem(),
              ),

              const SizedBox(height: 20.0),

              /// PRODUCT HORIZONTAL LIST
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(products: product),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 4),

              /// FIXED: PRODUCT VERTICAL LIST
              ///
              Text(
                'Recent Items',
                style: AppWidget.semiBoldTextFeildStyle().copyWith(
                  fontSize: 18,
                ),
              ),
              ListView.builder(
                itemCount: products.length,
                shrinkWrap: true, // ✅ tells ListView to size itself to children
                physics:
                    const NeverScrollableScrollPhysics(), // ✅ prevents nested scroll conflicts
                itemBuilder: (context, index) {
                  final product = products[index];
                  return VerticalList(
                    product: product,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(products: product),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildCategoryButton("assets/ice-cream.png", icecream, () {
          setState(() {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
          });
        }),
        buildCategoryButton("assets/pizza.png", pizza, () {
          setState(() {
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
          });
        }),
        buildCategoryButton("assets/salad.png", salad, () {
          setState(() {
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
          });
        }),
        buildCategoryButton("assets/burger.png", burger, () {
          setState(() {
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
          });
        }),
      ],
    );
  }

  Widget buildCategoryButton(String path, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            path,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
