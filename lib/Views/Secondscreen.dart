import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/Views/Formm.dart';
import '../consts.dart';
import '../controller.dart';
import 'ThirdScreen.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({Key? key}) : super(key: key);

  final NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
          child: ListView(
            children:[
              Column(
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
                      SizedBox(width: 60,),

                      ...List.generate(4, (index) => buildDot(index, context)), // Create dots, adjust number as needed
                    ],
                  ),
                  Text(
                    'Can you tell us a little\nbit about your baby?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  SizedBox(height: 30,),
                  Formm(),


                ],
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
