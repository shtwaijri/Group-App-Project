// }
// ignore_for_file: unnecessary_null_comparison

import 'package:essert_coffee/models/item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItemService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<ItemModel>> fetchItems() async {
    final response = await _client.from('items').select();

    if (response == null) throw Exception("No response from Supabase");

    return (response as List)
        .map((json) => ItemModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
