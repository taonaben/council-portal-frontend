import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:portal/constants/colors.dart';

class TermsOfService extends StatefulWidget {
  const TermsOfService({super.key});

  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  String _termsText = "Loading...";

  @override
  void initState() {
    super.initState();
    loadTerms();
  }

  Future<void> loadTerms() async {
    final text = await rootBundle
        .loadString('lib/assets/documents/terms&conditions.txt');
    setState(() {
      _termsText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background1,
      appBar: AppBar(
        title: const Text('Terms of Service'),
        backgroundColor: background1,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.share),
            onPressed: () {
              // Implement share functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SelectableText(_termsText, ),
        ),
      ),
    );
  }
}
