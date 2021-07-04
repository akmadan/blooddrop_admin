import 'package:blooddrop_admin/utils/colors.dart';
import 'package:blooddrop_admin/utils/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  var email = '';
  var name = '';
  var address = '';
  var password = '';

  void trysubmit() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if ((isValid)) {
      _formkey.currentState!.save();
      _submitAuthForm(name, address, email, password);
    }
  }

//-----------------------------------------------------------------------
// Firebase Authentication

  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(
      String name, String address, String email, String password) async {
    UserCredential credential;
    try {
      Fluttertoast.showToast(msg: 'This may take a while');
      credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection('bloodbanks')
          .doc(credential.user?.uid)
          .set({
        'name': name,
        'address': address,
        'email': email,
        'uid': credential.user?.uid
      });
      Navigator.of(context).pop();
    } on PlatformException catch (err) {
      var message = 'An error occured';
      if (err.message != null) {
        message = err.message.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ));
    } catch (err) {
      print(err);
    }
  }

  //--------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView(
        children: [
          SizedBox(height: 50),
          Container(
            height: width / 1.4,
            width: width / 1.4,
            padding: EdgeInsets.all(20),
            child: Lottie.asset('assets/doctor1.json'),
          ),
          Form(
            key: _formkey,
            child: Container(
              width: width,
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModifiedText(
                        weight: FontWeight.bold,
                        text: 'Register',
                        size: 30,
                        color: Colors.grey.shade900),
                    SizedBox(height: 20),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.lightgrey,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      //____________________FIRST NAME____________________
                      child: Center(
                        child: TextFormField(
                          key: ValueKey('name'),
                          cursorColor: AppColors.primary,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Blood Bank Name',
                            suffixIcon: Icon(
                              Icons.local_hospital_rounded,
                              color: Colors.grey.shade800,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Name should not be empty';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            name = value.toString();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.lightgrey,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      //____________________FIRST NAME____________________
                      child: Center(
                        child: TextFormField(
                          key: ValueKey('address'),
                          cursorColor: AppColors.primary,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Blood Bank Address',
                            suffixIcon: Icon(
                              Icons.place,
                              color: Colors.grey.shade800,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Address should not be empty';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            address = value.toString();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.lightgrey,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      //__________________EMAIL_______________________
                      child: Center(
                        child: TextFormField(
                          key: ValueKey('email'),
                          cursorColor: AppColors.primary,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Email Address',
                            suffixIcon: Icon(
                              Icons.mail,
                              color: Colors.grey.shade800,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Email should not be empty';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            email = value.toString();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.lightgrey,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      //______________________PASSWORD_____________________
                      child: Center(
                        child: TextFormField(
                          obscureText: true,
                          key: ValueKey('password'),
                          cursorColor: AppColors.primary,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Password',
                            suffixIcon: Icon(
                              Icons.security,
                              color: Colors.grey.shade800,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Password should not be empty';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            password = value.toString();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        trysubmit();
                      },
                      child: Container(
                        height: 54,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                            child: ModifiedText(
                          weight: FontWeight.bold,
                          text: 'Register',
                          color: Colors.white,
                          size: 18,
                        )),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
