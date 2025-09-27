import 'package:fast_order/core/error/error.dart';
import 'package:fast_order/core/useCase/usecase.dart';
import 'package:fast_order/features/order/domain/entity/placed_order_model.dart';
import 'package:fast_order/features/order/domain/repository/order_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetOrdersUseCase implements UseCase<List<PlacedOrderModel>, NoParams> {
  final OrderRepository repository;

  GetOrdersUseCase(this.repository);
  @override
  Future<Either<Failure, List<PlacedOrderModel>>> call(params) async {
    return await repository.getPlacedOrders();
  }
}

class NoParms {}
