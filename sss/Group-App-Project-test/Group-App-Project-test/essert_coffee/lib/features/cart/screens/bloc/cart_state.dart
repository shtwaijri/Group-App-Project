part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<ItemModel> items;
  CartLoaded(this.items);
}

final class SuccessState extends CartState {}

class ErrorState extends CartState {
  final String message;
  ErrorState(this.message);
}