import 'package:flutter/material.dart';
import 'package:portal/constants/colors.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget myWidget;
  final Widget? trailingAction;
  final Widget? floatingActionButton;
  const CustomScaffold(
      {super.key,
      required this.title,
      required this.myWidget,
      this.trailingAction,
      this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: background2,
        title: Text(title, style: const TextStyle(color: textColor1)),
        actions: [trailingAction ?? const SizedBox.shrink()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: myWidget,
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
