import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class CartLine {
  final String productId;
  final String? color;
  final String? size;
  final int qty;
  final int unitPrice;
  const CartLine({
    required this.productId, this.color, this.size,
    required this.qty, required this.unitPrice,
  });
  int get total => qty * unitPrice;
  CartLine copyWith({int? qty}) => CartLine(
    productId: productId, color: color, size: size,
    qty: qty ?? this.qty, unitPrice: unitPrice,
  );

  // Simple (de)serialization to store in Hive as Map
  Map<String, dynamic> toMap() => {
    'productId': productId, 'color': color, 'size': size,
    'qty': qty, 'unitPrice': unitPrice,
  };
  static CartLine fromMap(Map m) => CartLine(
    productId: m['productId'], color: m['color'], size: m['size'],
    qty: m['qty'], unitPrice: m['unitPrice'],
  );
}

class CartController extends StateNotifier<List<CartLine>> {
  CartController(this._box): super(_load(_box));
  final Box _box;
  static List<CartLine> _load(Box b) =>
    (b.get('lines', defaultValue: <Map>[]) as List)
      .map((m) => CartLine.fromMap(Map<String, dynamic>.from(m))).toList();

  void _save() => _box.put('lines', state.map((e)=>e.toMap()).toList());

  void add(CartLine line){
    final i = state.indexWhere((l)=> l.productId==line.productId && l.color==line.color && l.size==line.size);
    if (i==-1) state = [...state, line];
    else state = [...state]..[i] = state[i].copyWith(qty: state[i].qty + line.qty);
    _save();
  }
  void inc(int i){ state=[...state]..[i]=state[i].copyWith(qty:state[i].qty+1); _save(); }
  void dec(int i){ final q=state[i].qty; if(q>1){ state=[...state]..[i]=state[i].copyWith(qty:q-1);} else { remove(i);} _save(); }
  void remove(int i){ state=[...state]..removeAt(i); _save(); }
  int get grandTotal => state.fold(0,(s,l)=>s+l.total);
}

final cartProvider = StateNotifierProvider<CartController, List<CartLine>>((ref) {
  final box = Hive.box('cartBox');
  return CartController(box);
});
