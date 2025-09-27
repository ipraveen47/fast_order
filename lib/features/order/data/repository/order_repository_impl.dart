import 'package:fast_order/core/error/error.dart';
import 'package:fast_order/features/order/data/datasource/remote_data_source.dart';
import 'package:fast_order/features/order/data/model/cart_item_model.dart';
import 'package:fast_order/features/order/data/model/placed_order_model.dart';
import 'package:fast_order/features/order/domain/entity/cart_model.dart';
import 'package:fast_order/features/order/domain/entity/placed_order_model.dart';
import 'package:fast_order/features/order/domain/repository/order_repository.dart';
import 'package:fpdart/fpdart.dart' hide Order;

class OrderRepositoryImpl implements OrderRepository {
  final RemoteDataSource _dataSource;

  OrderRepositoryImpl({required RemoteDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, String>> placeOrder(List<CartItem> cartItems) async {
    try {
      final cartItemModels = cartItems
          .map((e) => CartItemModel.fromEntity(e))
          .toList();
      // Call the data source
      final docId = await _dataSource.placeOrder(cartItems: cartItemModels);
      return Right(docId);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addToCart(CartItem cartItem) async {
    try {
      final cart = CartItemModel.fromEntity(cartItem);
      await _dataSource.addToCart(cartItem: cart);
      return const Right("Added to cart successfully");
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      final cartItems = await _dataSource.getCartItems();
      final entities = cartItems.map((e) => e.toEntity()).toList();
      return Right(entities); // ✅ wrap in Right
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PlacedOrderModel>>> getPlacedOrders() async {
    try {
      // Fetch from data source
      final List<PlacedOrderDataModel> dataOrders = await _dataSource
          .getOrders();

      // Map data models to domain entities
      final List<PlacedOrderModel> domainOrders = dataOrders.map((data) {
        return PlacedOrderModel(
          id: data.id,
          cartItems: data.cartItems
              .map(
                (e) => e is CartItemModel ? e.toEntity() : e,
              ) // <-- check type
              .toList(),
          totalAmount: data.totalAmount,
          status: data.status,
          createdAt: data.createdAt,
        );
      }).toList();

      return Right(domainOrders);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
