import 'package:bloc/bloc.dart';
import 'package:essert_coffee/models/item_model.dart';
// import 'package:essert_coffee/models/cart_items_model.dart';
import 'package:essert_coffee/utilities/helper/cart_services.dart';
// import 'package:meta/meta.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final CartService cartService;

  ItemBloc(this.cartService) : super(ItemInitial()) {
    on<AddToCart>((event, emit) {
      cartService.addItem(event.item);
      emit(ItemAdded());
    });
  }
}
