import 'package:flutter/material.dart';

class IssuesCard extends StatefulWidget {
  final Map<String, dynamic> issue;
  const IssuesCard({super.key, required this.issue});

  @override
  State<IssuesCard> createState() => _IssuesCardState();
}

class _IssuesCardState extends State<IssuesCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.issue['category']),
      subtitle: Text(widget.issue['description']),
      trailing: Text(widget.issue['status']),
    );
  }
}
