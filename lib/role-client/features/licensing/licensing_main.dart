import 'package:flutter/material.dart';

class LicensingMainClient extends StatelessWidget {
  const LicensingMainClient({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        width: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(child: Text('Licenses')),
      ),
    );
  }
}