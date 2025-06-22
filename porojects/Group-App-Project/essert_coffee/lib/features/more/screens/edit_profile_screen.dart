// ignore_for_file: use_build_context_synchronously

import 'package:essert_coffee/features/auth/auth_service.dart';
import 'package:essert_coffee/features/more/screens/bloc/more_screen_bloc.dart';
import 'package:essert_coffee/features/more/widgets/container/phone_container.dart';
import 'package:essert_coffee/features/more/widgets/radio/radiolist_profile.dart';
import 'package:essert_coffee/features/more/widgets/textfeild/custom_profile_info_textfeild.dart';
import 'package:essert_coffee/style/style_size.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:essert_coffee/widgets/buttom_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

/// A screen for editing user profile information.
///
/// This screen provides input fields for a user's first name, last name, email,
/// phone number, and gender. It uses a BlocProvider to manage the state of
/// the editable fields and interacts with EditProfileBloc to update and with validation fr email & phone
/// retrieve profile details. Upon saving, it navigates back to the ProfileScreen.

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final bloc = context.read<MoreScreenBloc>();
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile", style: StyleText.bold24),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(context.getWidth() * .03),
              child: BlocBuilder<MoreScreenBloc, MoreScreenState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("First name", style: StyleText.bold20),
                      CustomProfileInfoTextfeild(
                        controller: bloc.firstNameController,
                      ),
                      Text("Last name", style: StyleText.bold20),
                      CustomProfileInfoTextfeild(
                        controller: bloc.lasttNameController,
                      ),
                      Text("email", style: StyleText.bold20),
                      Form(
                        key: bloc.formKey,
                        child: Column(
                          children: [
                            CustomProfileInfoTextfeild(
                              controller: bloc.emailtNameController,
                              validator: (value) {
                                if (!bloc.emailRegex.hasMatch(value!)) {
                                  return "emial shold be like example@example.com";
                                }
                                return null;
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Mobile number ",
                                style: StyleText.bold20,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                PhoneContainer(
                                  title: "+966",
                                  width: (context.getWidth() * .2),
                                ),

                                CustomProfileInfoTextfeild(
                                  controller: bloc.phoneNameController,
                                  isphone: true,
                                  validator: (value) {
                                    if (!bloc.numberRegExp.hasMatch(value!)) {
                                      return "phone must be number";
                                    }
                                    if (value.length < 9 || value.length > 9) {
                                      return "then length must be 9";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      StyleSize.sizeH16,
                      Text("Gender", style: StyleText.bold20),
                      Row(
                        children: [
                          RadiotProfile(
                            gender: "Male",
                            value: 'male',
                            groupValue: bloc.gender,
                            onChanged: (val) {
                              if (val != null) {
                                bloc.add(ChooseGenderEvent(gender: val));
                              }
                            },
                          ),
                          RadiotProfile(
                            gender: "Female",
                            value: 'female',
                            groupValue: bloc.gender,
                            onChanged: (val) {
                              if (val != null) {
                                bloc.add(ChooseGenderEvent(gender: val));
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 100),
                      ButtomWidget(
                        textElevatedButton: "continue",

                        onTab:
                            //حق بشرى
                            // if (bloc.formKey.currentState!.validate()) {
                            //   Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ProfileScreen(),
                            //     ),
                            //   );
                            // }
                            () async {
                              if (bloc.formKey.currentState!.validate()) {
                                //to update the database
                                final authService = AuthService();

                                try {
                                  //call update user data to send the updated data
                                  await authService.updateUserData(
                                    firstName: bloc.firstNameController.text,
                                    lastName: bloc.lasttNameController.text,
                                    email: bloc.emailtNameController.text,
                                    phone: bloc.phoneNameController.text,
                                  );
                                  //snack bar with message if the profile has been updated successfully

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Your profile has been updated successfully',
                                      ),
                                    ),
                                  );
                                  //go to profile screen
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => ProfileScreen(),
                                  //   ),
                                  // );
                                  bloc.add(
                                    InitEvent(),
                                  ); //update the values before pop context

                                  Navigator.pop(context);

                                  //snack bar with message to show error
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'There is an error while updating, try again later $e',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
