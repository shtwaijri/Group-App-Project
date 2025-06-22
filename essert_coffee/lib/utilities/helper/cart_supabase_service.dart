import 'package:essert_coffee/models/item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartSupabaseService {
  final supabase = Supabase.instance.client;
  Future<void> addItem({required int itemId, required int quantity}) async {
    final existing = await supabase
        .from('cart')
        .select()
        .eq('item_id', itemId)
        .eq('user_id', supabase.auth.currentUser?.id as Object)
        .single();

    final currentQuantity = existing['quantity'] as int;
    await supabase
        .from('cart')
        .update({'quantity': currentQuantity + quantity})
        .eq('id', existing['id']);
  }

  Future<void> updateQuantity({
    required String cartId,
    required int quantity,
  }) async {
    await supabase.from('cart').update({'quantity': quantity}).eq('id', cartId);
  }

  Future<void> removeItem(String cartId) async {
    await supabase.from('cart').delete().eq('id', cartId);
  }

  Future<List<ItemModel>> getCartItems() async {
    final result = await supabase
        .from('cart')
        .select('id, quantity, items (id, type, price, image_url)')
        .eq('user_id', supabase.auth.currentUser?.id as Object);

    return (result as List).map((map) => ItemModel.fromJson(map)).toList();
  }
}
