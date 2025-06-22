import 'package:essert_coffee/models/item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ItemRepo {
  //method to get the items from supabase
  Future<List<ItemModel>> getItems() async {
    //get the items from items table
    final response = await supabase.from('items').select();

    if (response.isEmpty) {
      return [];
    }
    //list to store the converted items from supabase
    List<ItemModel> items = [];

    //convert each item(json) to model using fromjson
    for (var element in response) {
      var item = ItemModel.fromJson(element);
      items.add(item);
    }
    //add the items to the list after converting
    return items;
  }
}
