import 'package:blooddrop_admin/components/drawer.dart';
import 'package:blooddrop_admin/pages/add.dart';
import 'package:blooddrop_admin/utils/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String useruid = '';

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  getuserdata() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid.toString();
    setState(() {
      useruid = uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        uid: useruid,
      ),
      appBar: AppBar(
          title: ModifiedText(
              text: 'BloodDrop Admin',
              color: Colors.white,
              size: 20,
              weight: FontWeight.bold)),
      body: Request(uid: useruid),
    );
  }
}
