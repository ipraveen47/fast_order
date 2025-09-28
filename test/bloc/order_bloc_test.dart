import 'package:bloc_test/bloc_test.dart';
import 'package:fast_order/core/error/error.dart';
import 'package:fast_order/features/order/domain/entity/cart_model.dart';
import 'package:fast_order/features/order/domain/usecase/add_to_cart_usecase.dart';
import 'package:fast_order/features/order/domain/usecase/get_cart_items_usecase.dart';
import 'package:fast_order/features/order/domain/usecase/get_orders.dart';
import 'package:fast_order/features/order/domain/usecase/place_order_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fast_order/features/order/presentation/bloc/order_bloc.dart';
import 'package:fast_order/core/local_data/product.dart';

// ----- MOCKS -----
class MockAddToCartUsecase extends Mock implements AddToCartUsecase {}

class MockPlaceOrderUsecase extends Mock implements PlaceOrderUsecase {}

class MockGetCartItemsUsecase extends Mock implements GetCartItemsUsecase {}

class MockGetOrderuseCase extends Mock implements GetOrdersUseCase {}

class FakeAddToCartParams extends Fake implements AddToCartParams {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeAddToCartParams());
  });
  late MockAddToCartUsecase mockAddToCart;
  late MockPlaceOrderUsecase mockPlaceOrder;
  late MockGetCartItemsUsecase mockGetCartItems;
  late MockGetOrderuseCase mockGetOrders;
  late OrderBloc orderBloc;

  final testProduct = Product(
    id: '1',
    imagePath: 'assets/salad2.png',
    title: 'Test Product',
    subtitle: 'Test Subtitle',
    price: 50.0,
    description: 'Test Description',
    deliveryTime: '20 min',
  );

  setUp(() {
    mockAddToCart = MockAddToCartUsecase();
    mockPlaceOrder = MockPlaceOrderUsecase();
    mockGetCartItems = MockGetCartItemsUsecase();
    mockGetOrders = MockGetOrderuseCase();
    orderBloc = OrderBloc(
      addToCartUsecase: mockAddToCart,
      placeOrderUsecase: mockPlaceOrder,
      getCartItemsUsecase: mockGetCartItems,
      getOrdersUseCase: mockGetOrders,
    );
  });

  tearDown(() {
    orderBloc.close();
  });

  final testCartItem = CartItem(
    productName: "Test Product",
    totalPrice: 50.0,
    quantity: 1,
  );

  blocTest<OrderBloc, OrderState>(
    'emits [loading, success] when AddToCartEvent succeeds',
    build: () {
      when(
        () => mockAddToCart(any()),
      ).thenAnswer((_) async => Right('Added to cart successfully'));
      return orderBloc;
    },
    act: (bloc) => bloc.add(AddToCartEvent(cartItem: testCartItem)),
    expect: () => [
      isA<OrderState>().having((s) => s.isLoading, 'isLoading', true),
      isA<OrderState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.cartItems.length, 'cartItems length', 1)
          .having(
            (s) => s.successMessage,
            'successMessage',
            'Added to cart successfully',
          ),
    ],
    verify: (_) {
      verify(() => mockAddToCart(any())).called(1);
    },
  );

  blocTest<OrderBloc, OrderState>(
    'emits [loading, error] when AddToCartEvent fails',
    build: () {
      when(
        () => mockAddToCart(any()),
      ).thenAnswer((_) async => Left(Failure('Something went wrong')));
      return orderBloc;
    },
    act: (bloc) => bloc.add(AddToCartEvent(cartItem: testCartItem)),
    expect: () => [
      isA<OrderState>().having((s) => s.isLoading, 'isLoading', true),
      isA<OrderState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having(
            (s) => s.errorMessage,
            'errorMessage',
            'Something went wrong',
          ),
    ],
  );
}
