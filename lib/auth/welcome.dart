import 'package:blooddrop_admin/utils/colors.dart';
import 'package:blooddrop_admin/utils/constants.dart';
import 'package:blooddrop_admin/utils/text.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Container(
        height: height,
        width: width,
        child: ListView(
          children: [
            SizedBox(height: height! / 20),
            Container(
              height: width! / 1.2,
              width: width! / 1.2,
              padding: EdgeInsets.all(20),
              child: Lottie.asset('assets/doctor2.json'),
            ),
            Container(
              width: width,
              padding: EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModifiedText(
                        weight: FontWeight.bold,
                        text: 'Welcome Back!',
                        color: AppColors.darktext,
                        size: 40),
                    SizedBox(height: 20),
                    ModifiedText(
                        weight: FontWeight.bold,
                        text: 'Help People ',
                        color: AppColors.darktext,
                        size: 20),
                    ModifiedText(
                        weight: FontWeight.w600,
                        text: 'To Receive Blood!',
                        color: AppColors.darktext,
                        size: 24),
                  ]),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 54,
              width: width,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary)),
                onPressed: () {},
                child: ModifiedText(
                  text: 'Login to Account',
                  color: AppColors.white,
                  size: 20,
                  weight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 54,
              width: width,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary)),
                onPressed: () {},
                child: ModifiedText(
                  text: 'Create a New Account',
                  color: AppColors.white,
                  size: 20,
                  weight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
