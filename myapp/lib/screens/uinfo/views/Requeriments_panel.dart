import 'package:flutter/material.dart';

class RequerimentsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, bool> requirements = {
      'Valid Passport': true,
      'Proof of English proficiency': false,
      'GPA > 4': false,
      'Health insurance': true,
      'Academic transcripts': true,
      'Visa': true,
      'Local language certificate': true,
    };

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: requirements.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Icon(
                    entry.value ? Icons.check : Icons.close,
                    color: entry.value ? Colors.green : Colors.red,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
