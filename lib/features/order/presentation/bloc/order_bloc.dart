import 'package:fast_order/core/useCase/usecase.dart';
import 'package:fast_order/features/order/domain/entity/cart_model.dart';
import 'package:fast_order/features/order/domain/entity/placed_order_model.dart';
import 'package:fast_order/features/order/domain/usecase/add_to_cart_usecase.dart';
import 'package:fast_order/features/order/domain/usecase/get_cart_items_usecase.dart';
import 'package:fast_order/features/order/domain/usecase/get_orders.dart';
import 'package:fast_order/features/order/domain/usecase/place_order_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PlaceOrderUsecase placeOrderUsecase;
  final AddToCartUsecase addToCartUsecase;
  final GetCartItemsUsecase getCartItemsUsecase;
  final GetOrdersUseCase getOrdersUseCase;

  OrderBloc({
    required this.getCartItemsUsecase,
    required this.addToCartUsecase,
    required this.placeOrderUsecase,
    required this.getOrdersUseCase,
  }) : super(OrderInitial()) {
    on<PlaceOrderEvent>(_placeOrder);
    on<AddToCartEvent>(_addToCart);
    on<GetCartEvent>(_getCartItems);
    on<GetPlacedOrdersEvent>(_getPlacedOrders);
  }

  /// 🔑 Clears all transient messages after showing SnackBars in UI
  // void clearMessages() {
  //   emit(
  //     state.copyWith(
  //       errorMessage: null,
  //       successMessage: null,
  //       placeOrderMessage: null,
  //     ),
  //   );
  // }

  Future<void> _getPlacedOrders(
    GetPlacedOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(GetPlacedOrdersLoading());
    try {
      final orders = await getOrdersUseCase(NoParams());
      orders.fold(
        (failure) => emit(GetPlacedOrdersFailure(message: failure.message)),
        (orders) => emit(GetPlacedOrdersSuccess(placedOrders: orders)),
      );
    } catch (e) {
      emit(GetPlacedOrdersFailure(message: e.toString()));
    }
  }

  Future<void> _getCartItems(
    GetCartEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final result = await getCartItemsUsecase(NoParams());

      result.fold(
        (failure) => emit(
          state.copyWith(isLoading: false, errorMessage: failure.message),
        ),
        (cartItems) => emit(
          state.copyWith(
            isLoading: false,
            cartItems: cartItems,
            errorMessage: null,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _addToCart(
    AddToCartEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(
      state.copyWith(isLoading: true, successMessage: null, errorMessage: null),
    );

    try {
      final res = await addToCartUsecase(AddToCartParams(event.cartItem));

      res.fold(
        (failure) => emit(
          state.copyWith(isLoading: false, errorMessage: failure.message),
        ),
        (message) => emit(
          state.copyWith(
            isLoading: false,
            successMessage: message, // e.g. "Added to cart successfully"
            cartItems: [...state.cartItems, event.cartItem],
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _placeOrder(
    PlaceOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(
      state.copyWith(
        isPlacingOrder: true,
        errorMessage: null,
        placeOrderMessage: null,
      ),
    );

    try {
      final result = await placeOrderUsecase(PlaceOrderParams(event.cartItem));

      result.fold(
        (failure) => emit(
          state.copyWith(isPlacingOrder: false, errorMessage: failure.message),
        ),
        (docId) => emit(
          state.copyWith(
            isPlacingOrder: false,
            cartItems: [], // ✅ clear cart on order success
            placeOrderMessage: 'Order placed successfully!',
            errorMessage: null,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isPlacingOrder: false, errorMessage: e.toString()));
    }
  }
}
