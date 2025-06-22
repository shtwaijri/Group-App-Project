import 'package:essert_coffee/features/nav/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [NavigationBarScreen] displays the main app screens with a bottom navigation bar.
///
/// It uses [NavigationBloc] to manage the current selected tab index.
class NavigationBarScreen extends StatelessWidget {
  const NavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<NavigationBloc>();
          return BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              if (state is! NavigationBarState) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              return Scaffold(
                body: bloc.screens[state.selectedIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state.selectedIndex,
                  onTap: (value) {
                    bloc.add(NavigationItemSelected(value));
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: state.selectedIndex == 0
                          ? Icon(Icons.dashboard)
                          : Icon(Icons.dashboard_outlined),
                      label: "Menu",
                    ),
                    BottomNavigationBarItem(
                      icon: state.selectedIndex == 1
                          ? Icon(Icons.local_mall)
                          : Icon(Icons.local_mall_outlined),
                      label: "Cart",
                    ),
                    BottomNavigationBarItem(
                      icon: state.selectedIndex == 2
                          ? Icon(Icons.bookmark)
                          : Icon(Icons.bookmark_outline),
                      label: "Orders",
                    ),
                    BottomNavigationBarItem(
                      icon: state.selectedIndex == 2
                          ? Icon(Icons.more_horiz)
                          : Icon(Icons.more_horiz_outlined),
                      label: "More",
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
