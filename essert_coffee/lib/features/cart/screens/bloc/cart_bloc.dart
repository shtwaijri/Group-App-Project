import 'package:bloc/bloc.dart';
import 'package:essert_coffee/models/item_model.dart';
import 'package:essert_coffee/utilities/helper/cart_services.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;
  CartBloc(this.cartService) : super(CartInitial()) {
    on<LoadCart>((event, emit) {
      emit(CartLoaded(cartService.items));
    });
    on<AddToCartEvent>((event, emit) {
      cartService.addItem(event.item);
      emit(CartLoaded(cartService.items));
    });
  }
}
