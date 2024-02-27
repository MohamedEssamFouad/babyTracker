
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/Views/SIXTHScreen.dart';
import '../controller.dart';
import 'Secondscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
final NavigationController navigationController = Get.put(NavigationController());

class INTRO extends StatelessWidget {




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Welocome to Baby Tracker',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,

                ),
              ),
               SizedBox(height: 10,),
              Text(
                'Grow up with your child',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.red

                ),
              ),
              SizedBox(height: 20,),
              Expanded(child: Center(child: Image(image: AssetImage('assets/images/istockphoto-913223532-612x612-removebg-preview.png')))),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
             Get.to(()=>SecondScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent,
                  ),
                  child: Text(
                    'Lets Start',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the content
                      children: [
                        Image(
                          image: NetworkImage('https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png'),
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                SizedBox(height: 15,),

              SizedBox(height: 8,),
              Center(
                child: Text(
                  'Received an invitation?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> completeIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
    Get.off(() => SIXTHScreen());
  }



}
