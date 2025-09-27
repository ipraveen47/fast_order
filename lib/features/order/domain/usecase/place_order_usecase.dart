import 'package:fast_order/core/error/error.dart';
import 'package:fast_order/core/useCase/usecase.dart';
import 'package:fast_order/features/order/domain/entity/cart_model.dart';
import 'package:fast_order/features/order/domain/repository/order_repository.dart';
import 'package:fpdart/fpdart.dart';

class PlaceOrderUsecase implements UseCase<String, PlaceOrderParams> {
  // String for docId
  final OrderRepository repository;

  PlaceOrderUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(PlaceOrderParams params) async {
    return repository.placeOrder(params.cartItem);
  }
}

class PlaceOrderParams {
  final List<CartItem> cartItem;

  PlaceOrderParams(this.cartItem);
}
