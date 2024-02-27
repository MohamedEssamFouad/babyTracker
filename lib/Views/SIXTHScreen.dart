import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled5/model/DateCal.dart';
import '../controller.dart';
import '../model/DataSection.dart';
import '../model/dbb.dart';
import '../model/initNotifications.dart';
import 'future.dart';

final NavigationController navigationController = Get.find<NavigationController>();
final BabyTrackerDatabase babyTrackerDatabase = BabyTrackerDatabase();

final TextEditingController vaccineNameController = TextEditingController();
final TextEditingController vaccineNoteController = TextEditingController();
final TextEditingController weightNoteController = TextEditingController();
final TextEditingController heightNoteController = TextEditingController();
final TextEditingController medicineDoseController = TextEditingController();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class SIXTHScreen extends StatelessWidget {
  final TextEditingController MedicineName = TextEditingController();
  final TextEditingController MedicineNameNote = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  SIXTHScreen() {
    InitNotifications.init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [

            Date_CAl(),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  DataSection(title: "Vaccine History", data: navigationController.vaccineHistory),
                  DataSection(title: "Medicine History", data: navigationController.medicineHistory),
                  DataSection(title: "Weight History", data: navigationController.weightHistory),
                  DataSection(title: "Height History", data: navigationController.heightHistory),

                ],
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: ()=>_showInputForm(context, 'weight'),
                    child: Column(
                      children: [
                        Image(image: NetworkImage('https://e7.pngegg.com/pngimages/609/383/png-clipart-computer-icons-measuring-scales-measurement-weight-scale-miscellaneous-blue-thumbnail.png'),width: 30,height: 50,),
                        Text(
                          'Weight',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>_showInputForm(context, 'height'),
                    child: Column(
                      children: [
                        Image(image: NetworkImage('https://i.pinimg.com/564x/79/1d/92/791d92cc3315e0178304ed93e656a837.jpg'),width: 30,height: 50,),
                        Text(
                          'Height',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>_showInputForm(context, 'vaccine'),
                    child: Column(
                      children: [
                        Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/512/2746/2746616.png'),width: 30,height: 50,),
                        Text(
                          'vaccine',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>_showInputForm(context, 'medicine'),
                    child: Column(
                      children: [
                        Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/512/1529/1529570.png'),width: 30,height: 50,),
                        Text(
                          'medicine',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInputForm(BuildContext context, String type) {
    TextEditingController? noteController;
    TextEditingController? nameController;
    String hintText = '';
    String nameHintText = '';
    String imageUrl = '';

    switch (type) {
      case 'vaccine':
        noteController = vaccineNoteController;
        nameController = vaccineNameController;
        hintText = 'Enter Vaccine Note';
        nameHintText = 'Enter Vaccine Name';
        imageUrl = 'https://cdn-icons-png.flaticon.com/512/2746/2746616.png'; // Example URL for vaccine
        break;
      case 'weight':
        noteController = weightNoteController;
        nameController = weightController;
        hintText = 'Note';
        nameHintText = 'Select Weight';
        imageUrl = 'https://e7.pngegg.com/pngimages/609/383/png-clipart-computer-icons-measuring-scales-measurement-weight-scale-miscellaneous-blue-thumbnail.png';
        break;
      case 'height':
        noteController = heightNoteController;
        nameController = heightController;
        hintText = 'Enter Height Note';
        nameHintText = 'Enter Height (cm)';
        imageUrl = 'https://i.pinimg.com/564x/79/1d/92/791d92cc3315e0178304ed93e656a837.jpg'; // Example URL for height
        break;
      case 'medicine':
        noteController = MedicineNameNote;
        nameController = MedicineName;
        hintText = 'Enter Medicine Note';
        nameHintText = 'Enter Medicine Name';
        imageUrl = 'https://cdn-icons-png.flaticon.com/512/1529/1529570.png'; // Example URL for medicine
        break;
    }


    showDialog(
      context: context,
      builder: (context) => AlertDialog(


        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.network(imageUrl, width: 50, height: 50),

              ),
              Text('$type'),
              SizedBox(height: 10,),
              Container(

                decoration: BoxDecoration(


                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey,
                    )
                ),
                child: TextField(

                  controller: nameController,
                  decoration: InputDecoration(hintText: nameHintText,border: InputBorder.none),
                  keyboardType: type == 'weight' || type == 'height' ? TextInputType.number : TextInputType.text,
                ),
              ),
              SizedBox(height: 5,),
              if (type == 'medicine')
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey,
                      )
                  ),
                  child: TextField(
                      controller: medicineDoseController, decoration: InputDecoration(hintText: 'Enter Amount',border: InputBorder.none)),
                ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),

                ),
                child: TextField(

                  controller: noteController,
                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10),hintText: hintText,border: InputBorder.none),
                ),

              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),

                ),
                width: double.infinity,
                child: TextButton(onPressed:() async {
                  final DateTime? selectedDateTime = await _selectDateTime(context, navigationController.selectedDatee.value);
                  if (selectedDateTime != null) {
                    await _addRecord(type, selectedDateTime);
                    Navigator.pop(context);
                  }
                }, child: Text('Select time',style: TextStyle(color: Colors.grey),)),
              )

            ],
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[300], // Background color
                  ),
                  child: Icon(
                    Icons.close,

                    color: Colors.grey[400],
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.indigo.shade900,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      final DateTime? selectedDateTime = await _selectDateTime(context, navigationController.selectedDatee.value);
                      if (selectedDateTime != null) {
                        await _addRecord(type, selectedDateTime);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context, DateTime selectedDate) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    if (selectedTime == null) return null;

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  Future<void> _addRecord(String type, DateTime selectedDateTime) async {
    String title = '';
    String body = '';
    switch (type) {
      case 'vaccine':
        await _addNewVaccine(selectedDateTime);
        title = 'Vaccine Reminder';
        body = 'It\'s time for ${vaccineNameController.text} vaccine.';
        break;
      case 'medicine':
        await _addNewMedicine(selectedDateTime);
        title = 'Medicine Reminder';
        body = 'It\'s time to take your medicine: ${MedicineName.text}.';
        break;
      case 'weight':
        await _addNewWeight(selectedDateTime);
        title = 'Weight Check Reminder';
        body = 'Time to record the weight.';
        break;
      case 'height':
        await _addNewHeight(selectedDateTime);
        title = 'Height Check Reminder';
        body = 'Time to record the height.';
        break;
    }

    InitNotifications.scheduleNotification(flutterLocalNotificationsPlugin, title, body, selectedDateTime);
  }


  Future<void> _addNewVaccine(DateTime selectedDateTime) async {
    String vaccineName = vaccineNameController.text;
    String note = vaccineNoteController.text;
    int babyId = 1;

    try {
      await babyTrackerDatabase.insertVaccine(
          babyId, vaccineName, selectedDateTime, note: note);
      Get.snackbar('Success', 'Vaccine added successfully');
      vaccineNameController.clear();
      vaccineNoteController.clear();
      navigationController.update();
    } catch (e) {
      print("Error adding new vaccine: $e");
      Get.snackbar('Error', 'Failed to add new vaccine');
    }
  }

  final TextEditingController medicineDoseController = TextEditingController();

  Future<void> _addNewMedicine(DateTime selectedDateTime) async {
    String medicineName = MedicineName.text;
    String dose = medicineDoseController.text;
    String note = MedicineNameNote.text;
    int babyId = 1;

    try {
      await babyTrackerDatabase.insertMedicine(
          babyId, medicineName, dose, selectedDateTime, note: note);
      Get.snackbar('Success', 'Medicine added succesy');
      MedicineName.clear();
      medicineDoseController.clear();
      MedicineNameNote.clear();
      navigationController.update();
    } catch (e) {
      print("Error adding new medicine: $e");
      Get.snackbar('Error', 'Failed to add new medicine');
    }
  }


  Future<void> _addNewWeight(DateTime selectedDateTime) async {
    double weight = double.tryParse(weightController.text) ?? 0;
    String note = weightNoteController.text;
    int babyId = 1;


    try {
      await babyTrackerDatabase.insertWeight(
          babyId, weight, selectedDateTime, note: note, );
      Get.snackbar('Success', 'Weight added successfully');
      weightController.clear();
      weightNoteController.clear();
      navigationController.update();
    } catch (e) {
      print("Error adding new weight: $e");
      Get.snackbar('Error', 'Failed to add new weight');
    }
  }



  Future<void> _addNewHeight(DateTime selectedDateTime) async {
    double height = double.tryParse(heightController.text) ??0;
    String note = heightNoteController.text;
    int babyId = 1;
    String name = "";
    try {
      await babyTrackerDatabase.insertHeight(babyId, height, selectedDateTime, note : note, );
      Get.snackbar('Success', 'Height added successfully');
      heightController.clear();
      navigationController.update();
    } catch (e) {
      print("Error adding new height: $e");
      Get.snackbar('Error', 'Failed to add new height');
    }
  }
}