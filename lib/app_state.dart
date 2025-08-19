import 'package:flutter/material.dart';

/// Global cart list used across the app.
final List<Map<String, String>> cartItems = [];

/// Notifier tracking the number of items in the cart.
final ValueNotifier<int> cartItemsCount = ValueNotifier<int>(0);

/// Global liked products list wrapped in a ValueNotifier so listeners update
/// immediately when items are added or removed.
final ValueNotifier<List<Map<String, String>>> likedItemsNotifier =
    ValueNotifier<List<Map<String, String>>>([]);

List<Map<String, String>> get likedItems => likedItemsNotifier.value;

/// Notify listeners that the cart item count has changed.
void notifyCartChange() {
  cartItemsCount.value = cartItems.length;
}