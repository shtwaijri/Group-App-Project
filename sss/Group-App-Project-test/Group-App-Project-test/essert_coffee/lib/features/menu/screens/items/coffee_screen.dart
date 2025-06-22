import 'package:essert_coffee/features/menu/screens/items/bloc/items_bloc.dart';
import 'package:essert_coffee/models/item_model.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:essert_coffee/utilities/helper/cart_services.dart';
import 'package:essert_coffee/widgets/buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CoffeeScreen extends StatelessWidget {
  final ItemModel product;
  const CoffeeScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemBloc(GetIt.I<CartService>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Details',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.getWidth() * 0.9,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(product.imageUrl!, fit: BoxFit.contain),
                ),
                const SizedBox(height: 16),
                Text(product.type!, style: StyleText.bold24),
                const Divider(color: Colors.blueGrey, thickness: 0.3),
                const Text('Description', style: StyleText.bold20),
                const Text(
                  'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo.. Read More',
                  style: StyleText.regular16,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'price: ',
                        style: StyleText.bold20,
                        children: [
                          TextSpan(
                            text: '${product.price?.toStringAsFixed(2)} SAR',
                            style: StyleText.regular16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.blueGrey, thickness: 0.3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ItemBloc, ItemState>(
                      builder: (context, state) {
                        return ButtomWidget(
                          onTab: () {
                            context.read<ItemBloc>().add(AddToCart(product));
                            Navigator.pop(context);
                          },
                          textElevatedButton: 'Add to cart',
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
