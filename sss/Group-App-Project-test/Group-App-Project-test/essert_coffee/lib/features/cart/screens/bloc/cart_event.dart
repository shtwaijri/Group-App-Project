part of 'cart_bloc.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final ItemModel item;
  AddToCartEvent(this.item);
}

class IncreaseQuantityEvent extends CartEvent {
  final String cartId;
  final int newQuantity;
  IncreaseQuantityEvent(this.cartId, this.newQuantity);
}

class DecreaseQuantityEvent extends CartEvent {
  final String cartId;
  final int newQuantity;
  DecreaseQuantityEvent(this.cartId, this.newQuantity);
}

class RemoveItemEvent extends CartEvent {
  final String cartId;
  RemoveItemEvent(this.cartId);
}

class AmountEvent extends CartEvent {}