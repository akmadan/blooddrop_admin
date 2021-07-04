import 'package:blooddrop_admin/components/addwidgets.dart';
import 'package:blooddrop_admin/utils/colors.dart';
import 'package:blooddrop_admin/utils/text.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Request extends StatefulWidget {
  final String uid;

  const Request({Key? key, required this.uid}) : super(key: key);
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  place() async {
    String bg = BloodGroup.bloodgroup;
    String hospitalname = Hospital.namecontroller.text.toString();
    String hospitaladdress = Hospital.addresscontroller.text.toString();
    String contact = Contact.phonecontroller.text.toString();
    Position? position = Hospital.currentposition;
    var t = DateTime.now();
    String time = t.toString();
    String doc = time + contact;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            SizedBox(height: 20),
            BloodGroup(),
            Divider(),
            SizedBox(height: 20),
            Hospital(),
            Divider(),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Contact(),
            SizedBox(height: 15),
            Container(
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primary)),
                  onPressed: () {},
                  child: Center(
                    child: ModifiedText(
                        text: 'Done',
                        color: Colors.white,
                        size: 20,
                        weight: FontWeight.bold),
                  )),
            )
          ],
        ));
  }
}
