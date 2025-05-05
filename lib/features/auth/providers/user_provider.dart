// filepath: c:\Users\taona\Documents\my work\city_council_portal\frontend\portal\lib\providers\user_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/features/auth/model/user_model.dart';
import 'package:portal/features/auth/services/user_services.dart';

final userServiceProvider = Provider<UserService>((ref) => UserService());

final userProvider = FutureProvider.family<User?, int>((ref, id) async {
  final userService = ref.watch(userServiceProvider);
  return userService.getUserById(id);
});
