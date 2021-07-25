import 'package:blooddrop_admin/components/addwidgets.dart';
import 'package:blooddrop_admin/utils/colors.dart';
import 'package:blooddrop_admin/utils/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    String bloodbankname = Hospital.namecontroller.text.toString();
    String bloodbankaddress = Hospital.addresscontroller.text.toString();
    String contact = Contact.phonecontroller.text.toString();
    String units = Units.unitcontroller.text.toString();
    Position? position = Hospital.currentposition;
    var t = DateTime.now();
    String time = t.toString();
    String doc = time + contact;

    //-----------------------------
    if (bloodbankname != '' && bloodbankaddress != '' && contact != '') {
      FirebaseFirestore.instance
          .collection('bloodbanks')
          .doc(widget.uid)
          .collection('requests')
          .doc(doc)
          .set({
        'bg': bg,
        'doc': doc,
        'hospitalname': bloodbankname,
        'hospitaladdress': bloodbankaddress,
        'contact': contact,
        'latitude': position!.latitude,
        'longitude': position.longitude,
        'units': units
      });
      FirebaseFirestore.instance.collection('allrequests').doc(doc).set({
        'bg': bg,
        'doc': doc,
        'hospitalname': bloodbankname,
        'hospitaladdress': bloodbankaddress,
        'contact': contact,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'units': units
      });
      Fluttertoast.showToast(msg: 'Request Placed');
    } else {
      Fluttertoast.showToast(msg: 'Information Incomplete');
    }
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
            SizedBox(height: 20),
            Units(),
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
                  onPressed: () {
                    place();
                  },
                  child: Center(
                    child: ModifiedText(
                        text: 'Done',
                        color: Colors.white,
                        size: 20,
                        weight: FontWeight.bold),
                  )),
            ),
            SizedBox(height: 15),
          ],
        ));
  }
}
