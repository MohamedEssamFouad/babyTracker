import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../consts.dart';
import '../controller.dart';
import 'FourthScreen.dart';

class ThirdScreen extends StatelessWidget {
  final NavigationController navigationController = Get.find<NavigationController>();

  ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back, size: 30, color: Consts.myGrayColor),
                  ),
                  SizedBox(width: 60),
                  ...List.generate(4, (index) => buildDot(index, context)),
                ],
              ),
              Text(
                'When is ${navigationController.babyName.value}' 's birthday?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 25,),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: navigationController.babyBirthday.value ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != navigationController.babyBirthday.value) {
                    navigationController.setBabyBirthday(pickedDate);
                  }
                },
                child: Obx(() => Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(
                    navigationController.babyBirthday.value != null
                        ? '${navigationController.babyBirthday.value!.year}-${navigationController.babyBirthday.value!.month}-${navigationController.babyBirthday.value!.day}'
                        : 'Select Baby\'s Birthday',
                    style: TextStyle(
                      fontSize: 18,
                      color: navigationController.babyBirthday.value != null ? Colors.black : Colors.grey,
                    ),
                  ),
                )),
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  Text('Is your born earyl/late',style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,

                  ),),
                  Spacer(),
                  Obx(() => Switch(
                    value: navigationController.val.value,
                    onChanged: (value) {
                      navigationController.val.value = value;
                    },
                  )),
                ],
              ),
              SizedBox(height: 25,),

              Obx(() {
                if (navigationController.val.value==true) {
                  return GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: navigationController.babyBirthday.value ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null && pickedDate != navigationController.babyBirthday.value) {
                        navigationController.setBabyBirthday(pickedDate);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        navigationController.babyBirthday.value != null
                            ? '${navigationController.babyBirthday.value!.year}-${navigationController.babyBirthday.value!.month}-${navigationController.babyBirthday.value!.day}'
                            : 'Select Baby\'s Birthday',
                        style: TextStyle(
                          fontSize: 18,

                          color: navigationController.babyBirthday.value != null ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  );
                } else {

                  return Container();
                }
              }),
              Spacer(),
              GestureDetector(
                onTap: (){
                  Get.to(()=>FourthScreen());
                  navigationController.changeIndex(2);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent,
                  ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: navigationController.currentIndex.value == index ? 25 : 25,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: navigationController.currentIndex.value == index ? Colors.purpleAccent : Consts.myGrayColor,
      ),
    );
  }
}
