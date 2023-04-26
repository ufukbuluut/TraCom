import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracom/Services/global_methods.dart';
import 'package:tracom/persistent/persistent.dart';
import 'package:tracom/widgets/AppText.dart';
import 'package:uuid/uuid.dart';

import '../Services/global_variables.dart';
import '../widgets/bottom_nav_bar.dart';
import 'offers_view.dart';

class Adverts extends StatefulWidget {
  const Adverts({super.key});

  @override
  State<Adverts> createState() => _AdvertsState();
}

class _AdvertsState extends State<Adverts> {
  final _formkey = GlobalKey<FormState>();
  DateTime? picked;
  Timestamp? dateTimeStamp;
  bool _isloading = false;

  final TextEditingController _countryController =
      TextEditingController(text: 'Select Country');

  final TextEditingController _offerTitleController = TextEditingController();

  final TextEditingController _offerDescripitionController =
      TextEditingController();

  final TextEditingController _dateController =
      TextEditingController(text: 'Offer Date');

  void dispose() {
    super.dispose();
    _countryController.dispose();
    _offerTitleController.dispose();
    _offerDescripitionController.dispose();
    _dateController.dispose();
  }

  Widget _textTitles({required String label}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontStyle: FontStyle.normal,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textFormFields({
    required String valueKey,
    required TextEditingController controller,
    required bool enabled,
    required Function fct,
    required int maxLength,
  }) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: InkWell(
          onTap: () {
            fct();
          },
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Value is missing';
              }
              return null;
            },
            controller: controller,
            enabled: enabled,
            key: ValueKey(valueKey),
            style: const TextStyle(
              color: Colors.black,
            ),
            maxLines: valueKey == 'OfferDescription' ? 4 : 1,
            maxLength: maxLength,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 241, 243, 246),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red))),
          ),
        ),
      ),
    );
  }

  _showTaskCategoriesDialog({required Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(230, 241, 243, 246),
            title: Text(
              'Countries',
              textAlign: TextAlign.center,
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Persistent.countryList.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _countryController.text =
                              Persistent.countryList[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add_location_alt_outlined),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              Persistent.countryList[index],
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: AppText(
                  text: 'Cancel',
                  size: 16,
                ),
              )
            ],
          );
        });
  }

  void _pickDateDialog() async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            '${picked!.day}/${picked!.month}/${picked!.year} ';
        dateTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(
            picked!.microsecondsSinceEpoch);
      });
    }
  }

  void _uploadTask() async {
    final ofID = const Uuid().v4();
    User? user = FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;
    final isValid = _formkey.currentState!.validate();

    if (isValid) {
      if (_dateController.text == 'Choose Offer Deadline Date' ||
          _countryController.text == 'Choose Your Country') {
        GlobalMethod.showErrorDialog(
            error: 'Please Pick Everything', ctx: context);
        return;
      }
      setState(() {
        _isloading = true;
      });
      try {
        await FirebaseFirestore.instance.collection('offers').doc(ofID).set({
          'ofID': ofID,
          'uploadedBy': _uid,
          'email': user.email,
          'ofTitle': _offerTitleController.text,
          'ofDescription': _offerDescripitionController.text,
          'ofDate': _dateController.text,
          'ofDateStamp': dateTimeStamp,
          'country': _countryController.text,
          'ofComments': [],
          'createdAt': Timestamp.now(),
          'name': name,
          'userImage': userImage,
          'location': location,
          'applicants': 0,
        });
        await Fluttertoast.showToast(
          msg: 'The Task Has Been Uploaded',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.grey,
          fontSize: 18,
        );
        _offerTitleController.clear();
        _offerDescripitionController.clear();
        setState(() {
          _countryController.text = 'Choose Your Country';
          _dateController.text = 'Choose Offer Deadline Date';
        });
      } catch (error) {
        setState(() {
          _isloading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
      } finally {
        setState(() {
          _isloading = false;
        });
      }
    } else {
      print('It is not valid');
    }
  }

  void getMydata() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      name = userDoc.get('name');
      userImage = userDoc.get('userImage');
    });
  }

  @override
  void initState() {
    super.initState();
    getMydata();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorUtility().maincolor,
      bottomNavigationBar: BottomNavigationBarForApp(indexNum: 2),
      appBar: AppBar(
        backgroundColor: ColorUtility().maincolor,
        leading: ProjectIcons().appLeftIcon,
        elevation: 0.0,
        centerTitle: true,
        title: appTitle(),
        actions: [
          ProjectIcons().appThreePointIcon,
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Card(
            color: ColorUtility().cardcolor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.symmetric(vertical: 18),
            elevation: 5,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AppText(text: 'Please fill all fields')),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _textTitles(label: 'Country'),
                          _textFormFields(
                              valueKey: 'Country',
                              controller: _countryController,
                              enabled: false,
                              fct: () {
                                _showTaskCategoriesDialog(size: size);
                              },
                              maxLength: 100),
                          _textTitles(label: 'Offer Title'),
                          _textFormFields(
                            valueKey: 'OfferTitle',
                            controller: _offerTitleController,
                            enabled: true,
                            fct: () {},
                            maxLength: 100,
                          ),
                          _textTitles(label: 'Offer Description'),
                          _textFormFields(
                            valueKey: 'OfferDescription',
                            controller: _offerDescripitionController,
                            enabled: true,
                            fct: () {},
                            maxLength: 100,
                          ),
                          _textTitles(label: 'Offer Date'),
                          _textFormFields(
                            valueKey: 'OfferDate',
                            controller: _dateController,
                            enabled: false,
                            fct: () {
                              _pickDateDialog();
                            },
                            maxLength: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: _isloading
                            ? const CircularProgressIndicator()
                            : MaterialButton(
                                onPressed: () {
                                  _uploadTask();
                                },
                                color: const Color.fromARGB(255, 241, 243, 246),
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Post Now'),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Icon(
                                        Icons.upload_file,
                                      )
                                    ],
                                  ),
                                ),
                              )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Text appTitle() {
  return Text(
    ProjectStrings().appTitle2,
    style: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.408,
    ),
  );
}
