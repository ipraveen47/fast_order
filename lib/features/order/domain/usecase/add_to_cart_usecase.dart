import 'package:fast_order/core/error/error.dart';
import 'package:fast_order/core/useCase/usecase.dart';
import 'package:fast_order/features/order/domain/entity/cart_model.dart';
import 'package:fast_order/features/order/domain/repository/order_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddToCartUsecase implements UseCase<void, AddToCartParams> {
  final OrderRepository repository;

  AddToCartUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(AddToCartParams params) async {
    return repository.addToCart(params.cartItem);
  }
}

class AddToCartParams {
  final CartItem cartItem;
  AddToCartParams(this.cartItem);
}
