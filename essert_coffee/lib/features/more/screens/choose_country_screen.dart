import 'package:essert_coffee/features/more/screens/bloc/more_screen_bloc.dart';
import 'package:essert_coffee/features/more/widgets/listtile/country_listtile.dart';
import 'package:essert_coffee/style/style_size.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/widgets/buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A screen that allows users to select their country from a list of options.
///
/// This screen displays a list of countries, each represented by a CountryListtile widget.
/// Users can tap on a country to select it, and their choice is managed by the
/// ProfileDetailsBloc. A "continue" button is provided to navigate back
/// to the previous screen once a selection is made.

class ChooseCountryScreen extends StatelessWidget {
  const ChooseCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final bloc = context.read<MoreScreenBloc>();
        return Scaffold(
          body: SafeArea(
            child: BlocBuilder<MoreScreenBloc, MoreScreenState>(
              builder: (context, state) {
                return Column(
                  children: [
                    StyleSize.sizeH16,
                    Align(
                      alignment: Alignment(-.8, 0),
                      child: Text("choose Country", style: StyleText.bold24),
                    ),
                    StyleSize.sizeH24,
                    CountryListtile(
                      color: bloc.country == 1
                          ? Color(0xff84c5b1)
                          : Colors.transparent,
                      onTap: () {
                        bloc.add(SelesctionCounteryEvent(country: 1));
                      },
                      title: "\tSaudi Arabia",
                      imagePath: "assets/images/4.png",
                    ),
                    CountryListtile(
                      onTap: () {
                        bloc.add(SelesctionCounteryEvent(country: 2));
                      },
                      title: "\tUnited Kingdom",
                      imagePath: "assets/images/5.png",
                      color: bloc.country == 2
                          ? Color(0xff84c5b1)
                          : Colors.transparent,
                    ),
                    SizedBox(height: 450),
                    ButtomWidget(
                      textElevatedButton: "continue",
                      onTab: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
