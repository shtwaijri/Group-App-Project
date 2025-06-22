import 'package:essert_coffee/features/auth/screens/login/login_screen.dart';
import 'package:essert_coffee/features/more/screens/bloc/more_screen_bloc.dart';
import 'package:essert_coffee/features/more/screens/profile_screen.dart';
import 'package:essert_coffee/features/more/widgets/button/profile_logout_button.dart';
import 'package:essert_coffee/features/more/widgets/listtile/custom_list_tile.dart';
import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_size.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:essert_coffee/utilities/helper/onesignal_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreScreenBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<MoreScreenBloc>();
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                Container(
                  padding: EdgeInsets.only(right: context.getWidth() * .05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      context.getWidth() * .2,
                    ),
                  ),
                  width: context.getWidth() * .2,
                  height: context.getHeight() * .2,
                  child: ClipOval(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset("assets/images/2.jpg", fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(context.getWidth() * .015),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello", style: StyleText.bold24),
                  StyleSize.sizeH8,
                  //linke with bloc and databse
                  BlocBuilder<MoreScreenBloc, MoreScreenState>(
                    builder: (context, state) {
                      return Text(
                        "${bloc.firstName} ${bloc.lastName}",
                        style: StyleText.bold24,
                      );
                    },
                  ),
                  StyleSize.sizeH8,
                  Divider(
                    color: StyleColor.lightBrown,
                    thickness: context.getWidth() * .03,
                    height: context.getHeight() * .04,
                    indent: context.getWidth() * .01,
                    endIndent: context.getWidth() * .7,
                  ),
                  CustomListTile(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider.value(
                              value: bloc,
                              child: ProfileScreen(),
                            );
                          },
                        ),
                      );
                    },
                    title: "profile",
                    icon: Icons.person_2_outlined,
                    height: context.getHeight() * .1,
                  ),
                  CustomListTile(
                    onPressed: () {},
                    title: "Favourite Branches",
                    icon: Icons.favorite_border,
                    height: context.getHeight() * .1,
                  ),
                  StyleSize.sizeH16,
                  ProfileLogoutButton(
                    title: "Log out",
                    onPressed: () async {
                      bloc.add(LogOutEvent());
                      await sendNotificationByExternalId(
                        externalUserId: [bloc.currentExternalId!],
                        title: "You've been logged out",
                        message: "Hope to see you soon!",
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),

                  ProfileLogoutButton(
                    title: "Delete my account",
                    onPressed: () async {
                      bloc.add(DeleteUerEvent());
                       Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
