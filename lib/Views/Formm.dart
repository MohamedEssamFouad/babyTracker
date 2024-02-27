import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller.dart';
import 'ThirdScreen.dart';

class Formm extends StatelessWidget {
  final NavigationController navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(border: InputBorder.none),
                value: navigationController.relationship.value,
                hint: const Text('Your relationship with the baby'),
                onChanged: (String? newValue) {
                  navigationController.setRelationship(newValue);
                },
                items: <String>['Mother', 'Father', 'Guardian', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Field required' : null,
              ),
            ),
          ),
          SizedBox(height: 50),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Baby's name",
                  border: InputBorder.none,
                ),
                onChanged: (value) => navigationController.setBabyName(value),
                validator: (value) {
                  return value!.isEmpty ? 'Please enter the baby\'s name' : null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GenderSelectionContainer(
                      label: 'Boy',
                      iconData: Icons.male,
                      isSelected: navigationController.gender.value == 'Boy',
                      onTap: () => navigationController.setGender('Boy'),
                    ),
                  ),
                  SizedBox(width: 30,),
                  Expanded(
                    child: GenderSelectionContainer(
                      label: 'Girl',
                      iconData: Icons.female,
                      isSelected: navigationController.gender.value == 'Girl',
                      onTap: () => navigationController.setGender('Girl'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 250),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
                  () => GestureDetector(
                onTap: navigationController.isFormValid
                    ? () {
                  navigationController.changeIndex(1);
                  Get.to(() => ThirdScreen());
                }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: navigationController.isFormValid ? Colors.blue : Colors.grey,  // Change color based on form validity
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderSelectionContainer extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderSelectionContainer({
    Key? key,
    required this.label,
    required this.iconData,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.blueAccent : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 20, color: isSelected ? Colors.white : Colors.grey),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
          ],
        ),
      ),
    );
  }
}
