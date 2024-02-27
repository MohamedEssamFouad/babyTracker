import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FutureBuilderSection extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> future;
  final String title;

  const FutureBuilderSection({Key? key, required this.future, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return SingleChildScrollView(
            child: _buildEntryList(snapshot.data!),
          );
        } else {
          return Center(
            child: Text('No entries found for this day in $title.'),
          );
        }
      },
    );
  }

  Widget _buildEntryList(List<Map<String, dynamic>> data) {
    // Sort the data by date before building the widgets
    data.sort((a, b) {
      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);
      return dateA.compareTo(dateB);
    });

    List<Widget> entryWidgets = data.map((entry) {
      String formattedDate = DateFormat('h:mm a').format(DateTime.parse(entry['date']));
      bool isMedicine = entry.containsKey('dose');

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry['name'] ?? 'Record', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('Time: $formattedDate'),
          if (entry['weight'] != null) Text('Weight: ${entry['weight']} kg'),
          if (entry['height'] != null) Text('Height: ${entry['height']} cm'),
          if (isMedicine && entry['dose'] != null) Text('Dose: ${entry['dose']}'),
          Text('Note: ${entry['note'] ?? ''}'),
          Divider(),
        ],
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: entryWidgets,
    );
  }
}
