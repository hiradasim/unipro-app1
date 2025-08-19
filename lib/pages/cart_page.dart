import 'package:flutter/material.dart';
import '../app_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _parsePrice(String? price) {
    if (price == null) return 0;

    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    var value = price;
    for (var i = 0; i < 10; i++) {
      value = value.replaceAll(persianDigits[i], i.toString());
      value = value.replaceAll(arabicDigits[i], i.toString());
    }

    value = value.replaceAll(RegExp(r'[\,\u060C\u066C]'), '');

    final numeric = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numeric) ?? 0;
  }

  int get total =>
      cartItems.fold(0, (sum, item) => sum + _parsePrice(item['price']));

  @override
  void dispose() {
    notifyCartChange();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سبد خرید')),
      body: cartItems.isEmpty
          ? const Center(child: Text('سبد خرید خالی است'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: item['image'] != null && item['image']!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['image']!,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox(width: 56, height: 56),
                    title: Text(item['name'] ?? ''),
                    subtitle: Text(item['price'] ?? ''),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          cartItems.removeAt(index);
                        });
                        notifyCartChange();
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 6, offset: Offset(0, -2)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('مجموع: ${total.toString()} تومان',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('پرداخت'),
                  ),
                ],
              ),
            ),
    );
  }
}