import 'package:blooddrop_admin/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Edit extends StatefulWidget {
  final String uid, doc, units, contact;
  const Edit(
      {Key? key,
      required this.uid,
      required this.doc,
      required this.units,
      required this.contact})
      : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    TextEditingController unitscontroller =
        TextEditingController(text: widget.units);
    TextEditingController contactcontroller =
        TextEditingController(text: widget.contact);
    return Scaffold(
      appBar: AppBar(title: Text('Edit')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          TextField(
            controller: unitscontroller,
            decoration: InputDecoration(
                hintText: 'Enter Units', border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          TextField(
            controller: contactcontroller,
            decoration: InputDecoration(
                hintText: 'Enter Contact', border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primary)),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('allrequests')
                        .doc(widget.doc)
                        .update({
                      'units': unitscontroller.text,
                      'contact': contactcontroller.text
                    });
                    await FirebaseFirestore.instance
                        .collection('bloodbanks')
                        .doc(widget.uid)
                        .collection('requests')
                        .doc(widget.doc)
                        .update({
                      'units': unitscontroller.text,
                      'contact': contactcontroller.text
                    });
                    Fluttertoast.showToast(msg: 'Updated Successfully');
                  },
                  child: Text('Update')))
        ]),
      ),
    );
  }
}
