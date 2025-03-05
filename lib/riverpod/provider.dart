import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a User model
class UserModel {
  final String username;
  final String lastname;

  UserModel({required this.username, required this.lastname});
}

// StateNotifier to manage user state
class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier() : super(UserModel(username: '', lastname: ''));

  void updateUser({required String username, required String lastName}) {
    state = UserModel(username: username, lastname: lastName);
  }
}

// Riverpod Provider
final userProvider = StateNotifierProvider<UserNotifier, UserModel>((ref) {
  return UserNotifier();
});

