import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts.dart';
import '../controller.dart';
import 'SIXTHScreen.dart';

class FifthScreen extends StatelessWidget {
  final NavigationController navigationController = Get.find<NavigationController>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
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
                  ...List.generate(4, (index) => buildDot(index, context)), // Create dots, adjust number as needed
                ],
              ),
              Image(image: AssetImage('assets/images/istockphoto-913223532-612x612-removebg-preview.png')),
            SizedBox(height: 50,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Never lose your data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Log in to securely back up your data and syncrhonize between multiple devices',
                    style: TextStyle(
                      color: Colors.grey,

                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 25,),
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(

                        children: [
                          Container(
                            height: 30,
                            color: Colors.white,
                            child: Image(


                              image: NetworkImage('https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png'

                                ,),
                              height: 30,


                            ),
                          ),
                          SizedBox(width: 35,),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 20,

                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(child: TextButton(onPressed: (){
                    completeIntro();
                  }, child: Text('Skip',

                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ))),
                ],
              ) ,

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
  Future<void> completeIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
    Get.off(() => SIXTHScreen());
  }
}
