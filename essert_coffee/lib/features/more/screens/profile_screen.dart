import 'package:essert_coffee/features/more/screens/choose_country_screen.dart';
import 'package:essert_coffee/features/more/screens/edit_profile_screen.dart';
import 'package:essert_coffee/features/more/screens/bloc/more_screen_bloc.dart';
import 'package:essert_coffee/features/more/screens/more_screen.dart';
import 'package:essert_coffee/features/more/widgets/card/profile_card.dart';
import 'package:essert_coffee/features/more/widgets/listtile/custom_list_tile.dart';
import 'package:essert_coffee/features/more/widgets/sizebox/country_sizebox.dart';
import 'package:essert_coffee/style/style_size.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The main profile screen for the user.
///
/// This screen displays the user's profile information, including their
/// name, gender, and phone number, presented within a ProfileCard. It also
/// provides an option to change the user's country via a CustomListTile,
/// which navigates to the ChooseCountryScreen. The screen manages its state
/// using ProfileDetailsBloc to react to changes in country selection.

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final bloc = context.read<MoreScreenBloc>();
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Profile", style: StyleText.bold24),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MoreScreen()),
                );
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(context.getWidth() * .03),
            child: BlocBuilder<MoreScreenBloc, MoreScreenState>(
              builder: (context, state) {
                return Column(
                  children: [
                    ProfileCard(
                      fullName: "${bloc.firstName} ${bloc.lastName}",
                      gender: bloc.gender,
                      phone: "+966${bloc.phoneNameController.text}",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider.value(
                                value: bloc,
                                child: EditProfileScreen(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    StyleSize.sizeH32,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("change Country", style: StyleText.bold20),
                    ),

                    CustomListTile(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider.value(
                                value: bloc,
                                child: ChooseCountryScreen(),
                              );
                            },
                          ),
                        );
                      },
                      title: bloc.country == 1
                          ? "\tSaudi Arabia"
                          : "United Kingdom",
                      icon: Icons.flag,
                      height: context.getHeight() * .1,
                      isCoutrty: true,
                      contry: CountrySizebox(
                        imagePath: bloc.country == 1
                            ? "assets/images/4.png"
                            : "assets/images/5.png",
                      ),
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
