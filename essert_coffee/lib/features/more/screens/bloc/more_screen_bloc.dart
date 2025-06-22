import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:essert_coffee/features/auth/auth_service.dart';
import 'package:essert_coffee/models/user_model.dart';
import 'package:essert_coffee/utilities/helper/onesignal_helper.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

part 'more_screen_event.dart';
part 'more_screen_state.dart';

/// BLoC class responsible for managing the state and logic of the MoreScreen.
/// It handles user profile data, OneSignal integration, and some UI-related state.
class MoreScreenBloc extends Bloc<MoreScreenEvent, MoreScreenState> {
  // Text editing controllers for user profile input fields.
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lasttNameController = TextEditingController();
  TextEditingController emailtNameController = TextEditingController();
  TextEditingController phoneNameController = TextEditingController();
  // GlobalKey for form validation.

  final formKey = GlobalKey<FormState>();
  // Regular expression for email validation.
  final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  // Current selected gender, defaults to 'male'.
  RegExp numberRegExp = RegExp(r'^[0-9]*$');
  String? currentExternalId; // Stores the OneSignal external user ID.
  // User profile data variables.
  String firstName = "";
  String lastName = "";
  String gender = "";
  String userId = "";
  int country = 1;
  AuthService authService = AuthService();

  /// Constructor for MoreScreenBloc.
  /// Initializes the state to MoreScreenInitial and sets up event handlers.
  MoreScreenBloc() : super(MoreScreenInitial()) {
    // Register event handlers for specific events.
    on<MoreScreenEvent>((event, emit) {});
    // Dispatch initial events when the BLoC is created.
    on<InitEvent>(initMethod);
    on<LoginSiginUpOnSignalEvent>(loginSiginUpOnSignaMethod);
    on<LogOutEvent>(logOutMethod);
    add(InitEvent());
    add(LoginSiginUpOnSignalEvent());
    on<SelesctionCounteryEvent>(selesctionCounteryMethod);
    on<ChooseGenderEvent>(chooseGenderMethod);
    on<DeleteUerEvent>(deleteUerMethod);
  }

  FutureOr<void> loginSiginUpOnSignaMethod(
    LoginSiginUpOnSignalEvent event,
    Emitter<MoreScreenState> emit,
  ) async {
    /// Handles the [LoginSiginUpOnSignalEvent].
    /// Logs the user into OneSignal, generating a new external ID if none exists.
    try {
      if (currentExternalId == null) {
        // Generate a new random external ID for the user.
        final newExternalId = 'user_${math.Random().nextInt(1000000)}';
        await OneSignal.login(
          newExternalId,
        ); // Perform OneSignal login with the new ID.

        currentExternalId = newExternalId;
        currentExternalId = newExternalId; // Store the new ID.
      }
    } catch (e) {
      throw ("erorr in _initializeOneSignalUser $e");
    }
    emit(
      LoginSiginUpOnSignalState(),
    ); // Emit a state indicating OneSignal login/signup attempt.
  }

  /// Handles the [LogOutEvent].
  /// Sends a logout notification to the user via OneSignal using their external ID.
  FutureOr<void> logOutMethod(
    LogOutEvent event,
    Emitter<MoreScreenState> emit,
  ) async {
    try {
      await authService.signOut();
      //delete user data
      firstName = "";
      lastName = "";
      gender = "";
      firstNameController.text = "";
      lasttNameController.text = "";
      emailtNameController.text = "";
      phoneNameController.text = "";
      emit(LogOutState());
    } catch (e) {
      throw ('Error sending notification: $e');
    }
  }

  /// Handles the [InitEvent].
  /// Fetches user data from AuthService and populates the text controllers.
  FutureOr<void> initMethod(
    InitEvent event,
    Emitter<MoreScreenState> emit,
  ) async {
    AuthService authService = AuthService();
    try {
      // Call service to get user data.
      UserModel? userData = await authService.fetchUserdataUsers();
      if (userData != null) {
        // Populate local variables with fetched data.
        firstName = userData.firstName;
        lastName = userData.lastName;
        gender = userData.gender;
        firstNameController.text = firstName;
        lasttNameController.text = lastName;
        emailtNameController.text = userData.email;
        phoneNameController.text = userData.phone;
        userId = userData.id;
      }
      // Emit a state indicating successful initialization.

      emit(InitState());
    } catch (e) {
      throw ("erro in  more screen $e");
    }
  }

  /// Handles the [SelesctionCounteryEvent].
  /// Updates the selected country ID.

  FutureOr<void> selesctionCounteryMethod(
    SelesctionCounteryEvent event,
    Emitter<MoreScreenState> emit,
  ) {
    // Update the country ID from the event.
    country = event.country;
    // Emit a state indicating the country selection change.
    emit(SelesctionCounteryState());
  }

  /// Handles the [ChooseGenderEvent].
  /// Emits a state with the chosen gender.
  FutureOr<void> chooseGenderMethod(
    ChooseGenderEvent event,
    Emitter<MoreScreenState> emit,
  ) {
    // Emit a state with the new gender.
    emit(ChooseGenderState(gender: event.gender));
  }

  FutureOr<void> deleteUerMethod(
    DeleteUerEvent event,
    Emitter<MoreScreenState> emit,
  ) {
    try {
      //delete user from database
      authService.deleteUser(userId);
    } catch (e) {}
  }
}
