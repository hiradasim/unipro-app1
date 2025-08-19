import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../app_state.dart';

class ProductPage extends StatefulWidget {
  final Map<String, String> product;

  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final Map<String, List<String>> _colorImages = {
    'grey': ['assets/grey_3.webp', 'assets/grey_2.webp'],
    'light purple': ['assets/light_purple_3.webp', 'assets/light_purple_2.webp'],
    'light brown': ['assets/light_brown_3.webp', 'assets/light_brown_2.webp'],
  };

  String _selectedColor = 'grey';
  late PageController _pageController;
  late bool _isLiked;
  bool _isAdding = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _isLiked = likedItemsNotifier.value
        .any((item) => item['name'] == widget.product['name']);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = _colorImages[_selectedColor]!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.product['name'] ?? ''),
        actions: [
          IconButton(
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked;
              });
              final current =
                  List<Map<String, String>>.from(likedItemsNotifier.value);
              if (_isLiked) {
                current.add(Map<String, String>.from(widget.product));
              } else {
                current.removeWhere(
                    (item) => item['name'] == widget.product['name']);
              }
              likedItemsNotifier.value = current;
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: appGradient),
        child: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: PageView.builder(
                  key: ValueKey(_selectedColor),
                  controller: _pageController,
                  itemCount: images.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _colorImages.keys.map((color) {
                Color displayColor;
                switch (color) {
                  case 'light purple':
                    displayColor = Colors.purple[100]!;
                    break;
                  case 'light brown':
                    displayColor = Colors.brown[200]!;
                    break;
                  default:
                    displayColor = Colors.grey;
                }
                final selected = color == _selectedColor;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: displayColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product['name'] ?? '',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.product['price'] ?? '',
                      style: TextStyle(color: Colors.green[700])),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _isAdding = true);
                        final item = {
                          'name': widget.product['name'] ?? '',
                          'price': widget.product['price'] ?? '',
                          'image': images.first,
                        };
                        cartItems.add(item);
                        notifyCartChange();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF2D95),
                                    Color(0xFF008CFF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.white),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${item['name']} به سبد اضافه شد',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 300),
                        scale: _isAdding ? 1.2 : 1.0,
                        onEnd: () {
                          if (mounted) {
                            setState(() => _isAdding = false);
                          }
                        },
                        child: const Icon(Icons.add_shopping_cart),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
