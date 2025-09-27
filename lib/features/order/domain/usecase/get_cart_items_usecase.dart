import 'package:fast_order/core/error/error.dart';
import 'package:fast_order/core/useCase/usecase.dart';
import 'package:fast_order/features/order/domain/entity/cart_model.dart';
import 'package:fast_order/features/order/domain/repository/order_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCartItemsUsecase implements UseCase<List<CartItem>, NoParams> {
  final OrderRepository repository;

  GetCartItemsUsecase(this.repository);
  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams parms) async {
    return await repository.getCartItems();
  }
}

class NoParms {}
