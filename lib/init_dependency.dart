import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_order/features/order/data/datasource/remote_data_source.dart';
import 'package:fast_order/features/order/data/repository/order_repository_impl.dart';
import 'package:fast_order/features/order/domain/repository/order_repository.dart';
import 'package:fast_order/features/order/domain/usecase/add_to_cart_usecase.dart';
import 'package:fast_order/features/order/domain/usecase/get_cart_items_usecase.dart';
import 'package:fast_order/features/order/domain/usecase/get_orders.dart';
import 'package:fast_order/features/order/domain/usecase/place_order_usecase.dart';
import 'package:fast_order/features/order/presentation/bloc/order_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _order();
}

void _order() {
  // data layer
  serviceLocator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(firestore: FirebaseFirestore.instance),
  );

  // domain layer
  serviceLocator.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(dataSource: serviceLocator()),
  );

  // usecase layer
  serviceLocator.registerFactory(() => PlaceOrderUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => AddToCartUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetCartItemsUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetOrdersUseCase(serviceLocator()));

  // bloc layer
  serviceLocator.registerFactory(
    () => OrderBloc(
      placeOrderUsecase: serviceLocator(),
      addToCartUsecase: serviceLocator(),
      getCartItemsUsecase: serviceLocator(),
      getOrdersUseCase: serviceLocator(),
    ),
  );
}
