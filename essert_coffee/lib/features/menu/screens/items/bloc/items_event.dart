part of 'items_bloc.dart';

abstract class ItemEvent {}

class AddToCart extends ItemEvent {
  final ItemModel item;
  AddToCart(this.item);
}
