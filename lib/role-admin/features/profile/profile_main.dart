import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/constants/colors.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Profile'),
        ),
        leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: background2,
            )),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(child: Text('Profile')),
        ),
      ),
    );
  }
}
