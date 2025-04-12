import 'package:flutter/cupertino.dart';
import 'package:portal/constants/colors/colors.dart';

class Visa extends StatelessWidget {
  const Visa({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        width: 400,
        decoration: BoxDecoration(
          color: background1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(child: Text('Visa')),
      ),
    );
  }
}
