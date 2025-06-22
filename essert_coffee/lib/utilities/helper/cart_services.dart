import 'package:essert_coffee/models/item_model.dart';

class CartService {
  final List<ItemModel> items = [];

  List<ItemModel> get coffee => List.unmodifiable(items);

  void addItem(ItemModel item) {
    final index = items.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      items[index].quantity += item.quantity;
    } else {
      items.add(item);
    }
  }

  void removeItem(String id) {
    items.removeWhere((item) => item.id == id);
  }

  void increaseQuantity(String id) {
    final index = items.indexWhere((e) => e.id == id);
    if (index != -1) {
      items[index].quantity += 1;
    }
  }

  void decreaseQuantity(String id) {
    final index = items.indexWhere((e) => e.id == id);
    if (index != -1 && items[index].quantity > 1) {
      items[index].quantity -= 1;
    }
  }

  void clear() => items.clear();
}
