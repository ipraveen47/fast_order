import 'package:fast_order/core/local_data/product.dart';

final List<Product> products = [
  Product(
    id: "1",
    imagePath: "assets/salad2.png",
    title: "Mediterranean",
    subtitle: "Chickpea Salad",
    price: 28.0,
    description:
        "A healthy Mediterranean chickpea salad with fresh veggies, herbs, and olive oil dressing.",
    deliveryTime: "30 min",
  ),
  Product(
    id: "2",
    imagePath: "assets/pizza.png",
    title: "Cheese Burst",
    subtitle: "Margherita Pizza",
    price: 15.0,
    description: "Classic Margherita pizza with extra cheese and fresh basil.",
    deliveryTime: "25 min",
  ),
];
