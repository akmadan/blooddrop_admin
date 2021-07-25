import 'package:blooddrop_admin/pages/myrequests.dart';
import 'package:blooddrop_admin/utils/colors.dart';
import 'package:blooddrop_admin/utils/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  final String uid;

  const DrawerWidget({Key? key, required this.uid}) : super(key: key);
  static String _url =
      'http://play.google.com/store/apps/details?id=com.company.blooddrop_admin';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey.shade100,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                color: Colors.grey.shade100,
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: ModifiedText(
                color: AppColors.black,
                weight: FontWeight.normal,
                text: 'Edit/Withdraw',
                size: 17,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => All(
                              useruid: uid,
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: ModifiedText(
                color: AppColors.black,
                weight: FontWeight.normal,
                text: 'Rate Us',
                size: 17,
              ),
              onTap: () async {
                await canLaunch(_url)
                    ? await launch(_url)
                    : throw 'Could not launch $_url';
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: ModifiedText(
                color: AppColors.black,
                weight: FontWeight.normal,
                text: 'Logout',
                size: 17,
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
