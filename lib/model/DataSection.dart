import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DataSection extends StatelessWidget {
  final String title;
  final RxList<Map<String, dynamic>> data;

  DataSection({required this.title, required this.data});

  Widget _buildEntryList(List<Map<String, dynamic>> data) {

    List<Map<String, dynamic>> sortedData = List.from(data)..sort((a, b) {
      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);
      return dateA.compareTo(dateB);

    });

    List<Widget> entryWidgets = sortedData.map((entry) {
      String formattedDate = DateFormat('h:mm a').format(DateTime.parse(entry['date']));
      String imageUrl = determineImageUrl(entry);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, width: 25, height: 25),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry['name'] ?? title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('Time: $formattedDate'),
                  if (entry['weight'] != null) Text('Weight: ${entry['weight']} kg'),
                  if (entry['height'] != null) Text('Height: ${entry['height']} cm'),
                  if (entry.containsKey('dose')) Text('Dose: ${entry['dose']}'),
                  if (entry['note'] != null) Text('Note: ${entry['note']}'),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: entryWidgets,
    );
  }

  String determineImageUrl(Map<String, dynamic> entry) {
    if (entry.containsKey('dose')) {
      return 'https://cdn-icons-png.flaticon.com/512/1529/1529570.png'; // Medicine icon
    } else if (entry['height'] != null) {
      return 'https://i.pinimg.com/564x/79/1d/92/791d92cc3315e0178304ed93e656a837.jpg'; // Height icon
    } else if (entry['weight'] != null) {
      return 'https://e7.pngegg.com/pngimages/609/383/png-clipart-computer-icons-measuring-scales-measurement-weight-scale-miscellaneous-blue-thumbnail.png'; // Weight icon
    } else {
      return 'https://cdn-icons-png.flaticon.com/512/2746/2746616.png'; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (data.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Center(child: Text('No $title for this day.')),
        );
      } else {
        return SingleChildScrollView(
          child: _buildEntryList(data.value),
        );
      }
    });
  }
}
