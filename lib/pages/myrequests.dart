import 'package:blooddrop_admin/utils/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class All extends StatefulWidget {
  final String useruid;

  const All({Key? key, required this.useruid}) : super(key: key);

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit/Withdraw'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('bloodbanks')
                  .doc(widget.useruid)
                  .collection('requests')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return new ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return RequestBubble(
                        uid: widget.useruid,
                        doc: data['doc'],
                        contact: data['contact'],
                        bg: data['bg'],
                        units: data['units'],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

//-------------------------------------

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
    return InkWell(
      onTap: () {
        // if (widget.ismine == false) {
        //   showAlertDialog(context);
        // }
      },
      child: Container(
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
          )),
    );
  }
}
