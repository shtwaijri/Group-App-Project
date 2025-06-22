import 'package:bloc/bloc.dart';
import 'package:essert_coffee/layer%20data/branch_data.dart';
import 'package:essert_coffee/models/item_model.dart';
import 'package:essert_coffee/utilities/helper/cart_services.dart';
import 'package:get_it/get_it.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  

  late int num = 2000;
  int total=0;
  final branchGetIt = GetIt.I.get<BranchData>();
  final CartService cartService;
  CartBloc(this.cartService) : super(CartInitial()) {
    on<LoadCart>((event, emit) {
      emit(CartLoaded(cartService.items));
    });
    on<AddToCartEvent>((event, emit) {
      cartService.addItem(event.item);
      emit(CartLoaded(cartService.items));
    });
     on<AmountEvent>((event, emit) {
      try {
        num = num * 100;
        print('NUM IS: $num');
        emit(SuccessState());
      } catch (e) {
        emit(ErrorState('Invalid amount format'));
      }
    });
    
  }
}
