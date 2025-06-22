import 'package:essert_coffee/features/cart/screens/bloc/cart_bloc.dart';
import 'package:essert_coffee/features/cart/screens/payment_screeen.dart';
import 'package:essert_coffee/features/cart/widgets/custom_order.dart';
import 'package:essert_coffee/models/item_model.dart';
import 'package:essert_coffee/utilities/helper/cart_services.dart';
// import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/widgets/buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  double calculateTotal(List<ItemModel> items) {
    return items.fold(
      0,
      (total, item) => total + (item.price! * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartBloc(GetIt.I<CartService>())..add(LoadCart()),
      child: Builder(
        builder: (context) {
          final bloc=context.read<CartBloc>();
          return Scaffold(
            
            appBar: AppBar(title: const Text('Cart Page')),
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<CartBloc, CartState>(
                      // i put bloc builder on listview.builder becouse stat.items.length will be error
                      buildWhen: (prev, curr) => curr is CartLoaded,
                      builder: (context, state) {
                        if (state is CartLoaded) {
                          return ListView.builder(
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              final item = state.items[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustumOrder(
                                  img: Image.network(item.imageUrl!),
                                  title: item.type!,
                                  price: item.price!,
                                  quantity: item.quantity,
                                  increaseQuantity: () {
                                    GetIt.I<CartService>().increaseQuantity(
                                      item.id as String,
                                    );
                                    bloc.add(LoadCart());
                                  },
                                  decreaseQuantity: () {
                                    GetIt.I<CartService>().decreaseQuantity(
                                      item.id as String,
                                    );
                                    bloc.add(LoadCart());
                                  },
                                  removeItem: () {
                                    GetIt.I<CartService>().removeItem(
                                      item.id as String,
                                    );
                                    bloc.add(LoadCart());
                                  },
                                ),
                              );
                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
          
                  const SizedBox(height: 16),
          
                  BlocBuilder<CartBloc, CartState>(
                    buildWhen: (prev, curr) => curr is CartLoaded,
                    builder: (context, state) {
                      if (state is CartLoaded) {
                        final total = calculateTotal(state.items).round();
                        bloc.num = total;
                        return ButtomWidget(
                          textElevatedButton: 'Pay $total SAR',
          
                          onTab: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: bloc,
                                    child: PaymentScreeen(),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
