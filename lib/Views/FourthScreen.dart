import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/controller.dart';

import '../consts.dart';
import 'FifthScreen.dart';

class FourthScreen extends StatelessWidget {
final NavigationController navigationController=Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
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
                'Great!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 25,),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage('https://cdn-icons-png.flaticon.com/512/4211/4211763.png'),
                          fit: BoxFit.cover,),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Pick Baby\'s photo',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Pick frame color',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                    ),
                    );
                  },
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  Get.to(()=>FifthScreen());
                  navigationController.changeIndex(3);
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
