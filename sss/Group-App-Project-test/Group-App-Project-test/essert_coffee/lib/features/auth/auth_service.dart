import 'dart:developer';

import 'package:essert_coffee/models/item_model.dart';
import 'package:essert_coffee/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  //instance of SupabaseClient for auth, database queries and etc..
  final SupabaseClient _supabase = Supabase.instance.client;
  //method for signup from supabase
  Future<void> signupByEmail(String email, String password) async {
    try {
      //variable to store signup result
      //send email and pass to supabase
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      //if the signup went successfully
      if (response.user != null) {
        return;
      }
      //clarify the error if user=null
      throw Exception('Failed Sign up, try again later');

      //to handle specific auth errors
    } on AuthException catch (e) {
      final msg = e.message.toLowerCase();
      if (msg.contains('user already registered') ||
          msg.contains('already registered') ||
          msg.contains('duplicate')) {
        //to clarify the error
        throw Exception('This email is already registered.');
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /////////////////////////////////////////////////////////////////
  //method for signin

  Future<AuthResponse> signInByEmail(String email, String password) async {
    //hold user data if the sign in went successfully with supabase method 'signInWithPassword'
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    //clarify the error if user=null
    if (response.user == null) {
      throw Exception('Sign in error');
    }

    ////////////////////////////////////////////////////////////////////////
    //clarify the error if the user has not verify his email
    // if (response.user!.emailConfirmedAt == null) {
    //   throw Exception(
    //     'you have to verify your email before login, check your email please',
    //   );
    // }
    /////////////////////////////////////////////////////////////////
    //call insertUserDataIfNotExist method to check user's data are exist
    await insertUserDataIfNotExist();
    return response;
  }

  //method to add user's data in users table if there are no data inserted before
  Future<void> insertUserDataIfNotExist() async {
    //to get current user data
    final user = _supabase.auth.currentUser;
    //to check if there was not a user has logged in, the function has to stop
    if (user == null) throw Exception('There is no user logged in');

    final existing = await _supabase
        //query to check if user's data is already exists in useres table
        .from('users')
        .select()
        .eq('id', user.id)
        .maybeSingle();
    //condition to check if no user data has found, we insert new empty data (record)
    if (existing == null) {
      await _supabase.from('users').insert({
        'id': user.id,
        'email': user.email,
        'first_name': '',
        'last_name': '',
        'phone': '',
      });
    }
  }

  //method to update user's data in the database

  Future<void> updateUserData({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    //get current user
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('There is no user logged in');

    //map with new user's data to update
    final updates = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
    };
    try {
      //send the updated data to useres table
      await _supabase.from('users').update(updates).eq('id', user.id);

      //if there is an error occured during updating, throw an exception
    } catch (e) {
      throw Exception('An error occured while updating the data. $e');
    }
  }

  //method to fetch the current user data from supabase users table

  Future<UserModel?> fetchUserdataUsers() async {
    //to get the current user from supabase
    final user = _supabase.auth.currentUser;

    if (user == null) return null;
    final response = await _supabase
        .from('users')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return null;

    //convert the data from the database to usermodel object
    return UserModel.fromMap(response);
  }

  Future<ItemModel?> fetchUserdataItems() async {
    //to get the current user from supabase
    final user = _supabase.auth.currentUser;

    if (user == null) return null;
    final response = await _supabase
        .from('items')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return null;

    //convert the data from the database to usermodel object
    return ItemModel.fromJson(response);
  }

  /// Method to sign out the current user.
  /// It clears the user session and tokens locally.
  /// Throws an exception if an error occurs during the sign-out process.
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      // Optional: You can add any additional logic here after successful sign out,
      // such as navigating the user to the login screen or clearing local data.
      log('User signed out successfully.');
    } on AuthException catch (e) {
      // Handle specific authentication errors during sign out (e.g., network issues).
      log('Error during sign out: ${e.message}');
      throw Exception('Failed to sign out: ${e.message}');
    } catch (e) {
      // Handle any other unexpected errors during sign out.
      log('An unexpected error occurred during sign out: $e');
      throw Exception('An unexpected error occurred during sign out.');
    }
  } // Method to delete a user

  Future<void> deleteUser(String userId) async {
    try {
      // Use the Supabase Admin API to delete the user
      await _supabase.auth.admin.deleteUser(userId);
    } catch (e) {
      throw Exception('An error occurred while deleting the user: $e');
    }
  }
}
