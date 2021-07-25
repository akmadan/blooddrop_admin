import 'package:blooddrop_admin/pages/edit.dart';
import 'package:blooddrop_admin/utils/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestBubble extends StatefulWidget {
  final String contact, bg, units, doc, uid;
  const RequestBubble({
    Key? key,
    required this.contact,
    required this.bg,
    required this.units,
    required this.doc,
    required this.uid,
  }) : super(key: key);

  @override
  _RequestBubbleState createState() => _RequestBubbleState();
}

class _RequestBubbleState extends State<RequestBubble> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModifiedText(
                        text: 'Blood Group: ' + widget.bg,
                        color: Colors.black,
                        size: 16,
                        weight: FontWeight.bold),
                    SizedBox(
                      height: 8,
                    ),
                    ModifiedText(
                        text: 'Units: ' + widget.units,
                        color: Colors.black,
                        size: 16,
                        weight: FontWeight.bold),
                    SizedBox(
                      height: 8,
                    ),
                    ModifiedText(
                        text: 'Contact: ' + widget.contact,
                        color: Colors.black,
                        size: 16,
                        weight: FontWeight.bold),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Edit(
                                      units: widget.units,
                                      contact: widget.contact,
                                      doc: widget.doc,
                                      uid: widget.uid,
                                    )));
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('allrequests')
                            .doc(widget.doc)
                            .delete();
                        await FirebaseFirestore.instance
                            .collection('bloodbanks')
                            .doc(widget.uid)
                            .collection('requests')
                            .doc(widget.doc)
                            .delete();
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            ],
          ),
        ));
  }
}
