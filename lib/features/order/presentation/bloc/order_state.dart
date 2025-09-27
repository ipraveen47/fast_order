part of 'order_bloc.dart';

@immutable
class OrderState {
  final bool isLoading; // for general loading
  final List<CartItem> cartItems;
  final String? orderId; // for success placing order
  final String? errorMessage; // for any errors
  final String? successMessage;
  final List<PlacedOrderModel> placedOrders;
  final bool isPlacingOrder;
  final String? placeOrderMessage;

  OrderState({
    this.isLoading = false,
    this.cartItems = const [],
    this.orderId,
    this.errorMessage,
    this.successMessage,
    this.isPlacingOrder = false,
    this.placedOrders = const [],
    this.placeOrderMessage,
  });

  // Copy with method for easy state updates
  OrderState copyWith({
    bool? isLoading,
    bool? isPlacingOrder,
    List<CartItem>? cartItems,
    List<PlacedOrderModel>? placedOrders,
    String? orderId,
    String? errorMessage,
    String? successMessage,
    String? placeOrderMessage,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      cartItems: cartItems ?? this.cartItems,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      placedOrders: placedOrders ?? this.placedOrders,
      orderId: orderId ?? this.orderId,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      placeOrderMessage: placeOrderMessage ?? this.placeOrderMessage,
    );
  }
}

final class OrderInitial extends OrderState {}

// add to cart states
final class AddToCartLoading extends OrderState {}

final class AddToCartSuccess extends OrderState {
  final String message;
  AddToCartSuccess({required this.message});
}

final class AddToCartFailure extends OrderState {
  final String error;

  AddToCartFailure(this.error);
}

// get placed orders states
class GetPlacedOrdersLoading extends OrderState {}

class GetPlacedOrdersSuccess extends OrderState {
  final List<PlacedOrderModel> placedOrders;
  GetPlacedOrdersSuccess({required this.placedOrders});
}

class GetPlacedOrdersFailure extends OrderState {
  final String message;
  GetPlacedOrdersFailure({required this.message});
}



// place order states

// class OrderLoading extends OrderState {}

// class OrderSuccess extends OrderState {
//   final String orderId;
//   OrderSuccess({required this.orderId});
// }

// class OrderFailure extends OrderState {
//   final String message;
//   OrderFailure({required this.message});
// }

// // get all cart items

// class CartItemsLoading extends OrderState {}

// class CartItemsSuccess extends OrderState {
//   final List<CartItem> cartItems;
//   CartItemsSuccess({required this.cartItems});
// }

// class CartItemsFailure extends OrderState {
//   final String message;
//   CartItemsFailure({required this.message});
// }