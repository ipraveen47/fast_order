import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:fast_order/features/order/data/model/cart_item_model.dart';
import 'package:fast_order/features/order/data/model/order_model.dart';
import 'package:fast_order/features/order/data/model/placed_order_model.dart';
import 'package:fast_order/features/order/domain/entity/cart_model.dart';

abstract interface class RemoteDataSource {
  Future<String> placeOrder({required List<CartItem> cartItems});
  Future<List<PlacedOrderDataModel>> getOrders();
  Future<void> addToCart({required CartItemModel cartItem});
  Future<List<CartItemModel>> getCartItems();
  Future<void> clearCart({required String productId});
  Future<String> checkout();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore firestore;

  RemoteDataSourceImpl({required this.firestore});

  @override
  Future<String> placeOrder({required List<CartItem> cartItems}) async {
    try {
      final orderRef = firestore.collection('orders').doc();

      // Convert domain entities to models
      final cartItemModels = cartItems
          .map((e) => CartItemModel.fromEntity(e))
          .toList();

      // Calculate totalAmount
      final totalAmount = cartItemModels.fold<double>(
        0,
        (sum, item) => sum + (item.totalPrice),
      );

      await orderRef.set({
        'cartItems': cartItemModels.map((e) => e.toMap()).toList(),
        'totalAmount': totalAmount,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // clear the cart

      final cartCollection = firestore.collection('cart');
      final snapshot = await cartCollection.get();

      for (final doc in snapshot.docs) {
        await cartCollection.doc(doc.id).delete();
      }

      return orderRef.id;
    } catch (e) {
      throw Exception('Failed to place order: $e');
    }
  }

  @override
  Future<List<PlacedOrderDataModel>> getOrders() async {
    try {
      final snapshot = await firestore
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .get();

      final orders = snapshot.docs.map((doc) {
        final data = doc.data();
        return PlacedOrderDataModel.fromMap(doc.id, data);
      }).toList();

      return orders;
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  @override
  Future<void> addToCart({required CartItemModel cartItem}) async {
    try {
      final cartRef = firestore.collection('cart').doc();

      await cartRef.set({
        ...cartItem.toMap(),
        'addedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      final snapshot = await firestore
          .collection('cart')
          .orderBy('addedAt', descending: true) // make sure 'addedAt' exists
          .get();

      return snapshot.docs
          .map((doc) => CartItemModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> clearCart({required String productId}) async {
    try {
      await firestore.collection('cart').doc(productId).delete();
    } catch (e) {
      throw Exception('Failed to clear cart item: $e');
    }
  }

  @override
  Future<String> checkout() async {
    try {
      final cartSnapshot = await firestore.collection('cart').get();
      if (cartSnapshot.docs.isEmpty) {
        return "Cart is empty!";
      }
      // Step 2: (Optional) Save order in 'orders' collection
      final orderRef = firestore.collection('orders').doc();
      final orderData = {
        'items': cartSnapshot.docs.map((doc) => doc.data()).toList(),
        'createdAt': FieldValue.serverTimestamp(),
      };
      await orderRef.set(orderData);
      // Step 3: Clear cart
      for (var doc in cartSnapshot.docs) {
        await firestore.collection('cart').doc(doc.id).delete();
      }
      // Step 4: Return success message
      return "Order placed successfully!";
    } catch (e) {
      throw Exception("Checkout failed: $e");
    }
  }
}
