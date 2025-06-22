import 'package:essert_coffee/features/menu/screens/cold_drink_screen.dart';
import 'package:essert_coffee/features/menu/screens/items/bloc/items_bloc.dart';
// import 'package:essert_coffee/features/menu/screens/hot_drink_screen.dart';
// import 'package:essert_coffee/features/menu/screens/juises_and_water.dart';
import 'package:essert_coffee/features/menu/widgets/custom_container.dart';
import 'package:essert_coffee/features/menu/widgets/custom_section.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/helper/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Menu', style: StyleText.bold24),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            children: [
              CustomContainer(height: 200, widget: Row(children: [])),
              SizedBox(height: 16),

              CustomContainer(height: 100, widget: Row(children: [])),
              SizedBox(height: 24),
              Text('Menu', style: StyleText.bold20),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSection(
                    img: 'assets/images/hot_drinks.png',
                    type: 'hot drinks',
                    screen: BlocProvider(
                      create: (_) => ItemBloc(GetIt.I<CartService>()),

                      child: ColdDrinkScreen(),
                    ),
                  ),
                  CustomSection(
                    img: 'assets/images/cold_drinks.png',
                    type: 'cold drinks',
                    screen: BlocProvider(
                      create: (_) => ItemBloc(GetIt.I<CartService>()),

                      child: ColdDrinkScreen(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  CustomSection(
                    img: 'assets/images/hot_drinks.png',
                    type: 'Juice',
                    screen: BlocProvider(
                      create: (_) => ItemBloc(GetIt.I<CartService>()),
                      child: ColdDrinkScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
