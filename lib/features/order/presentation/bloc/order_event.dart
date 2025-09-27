part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class PlaceOrderEvent extends OrderEvent {
  final List<CartItem> cartItem;
  PlaceOrderEvent({required this.cartItem});
}

class GetOrderEvent extends OrderEvent {}

class GetCartEvent extends OrderEvent {}

class AddToCartEvent extends OrderEvent {
  final CartItem cartItem;
  AddToCartEvent({required this.cartItem});
}

class GetPlacedOrdersEvent extends OrderEvent {}
