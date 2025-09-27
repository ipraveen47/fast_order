import 'package:fast_order/core/error/error.dart';
import 'package:fast_order/features/order/domain/entity/cart_model.dart';
import 'package:fast_order/features/order/domain/entity/placed_order_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class OrderRepository {
  Future<Either<Failure, String>> placeOrder(List<CartItem> cartItems);
  Future<Either<Failure, String>> addToCart(CartItem cartItem);
  Future<Either<Failure, List<CartItem>>> getCartItems();
  Future<Either<Failure, List<PlacedOrderModel>>> getPlacedOrders();
}
