import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracom/screens/TouristProffile.dart';
import 'package:tracom/screens/login_screen.dart';
import 'package:tracom/user_state.dart';
import 'package:tracom/widgets/AppText.dart';
import 'package:tracom/widgets/AppText2.dart';
import 'package:tracom/widgets/ReUsableButton.dart';
import 'package:tracom/widgets/ReUsableTextFormField.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../Services/global_methods.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final TextEditingController _fullNameController =
      TextEditingController(text: '');

  final TextEditingController _lastNameController =
      TextEditingController(text: '');

  final TextEditingController _emailTextController =
      TextEditingController(text: '');

  final TextEditingController _passTextController =
      TextEditingController(text: '');

  final TextEditingController _phoneNumberController =
      TextEditingController(text: '');

  final TextEditingController _locationController =
      TextEditingController(text: '');

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _locationFocusNode = FocusNode();
  final FocusNode _lastnameFocusNode = FocusNode();

  final _signUpFormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  bool _isLoading = false;
  File? imageFile;

  String? imageUrl;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _phoneNumberController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please Choose One Of The Following Options'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _getFromCamera();
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.purple),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image_search,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: Colors.purple),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void _submitFormOnSignUp() async {
    final isValid = _signUpFormKey.currentState!.validate();
    if (isValid) {
      if (imageFile == null) {
        GlobalMethod.showErrorDialog(
          error: 'Lütfen Fotoğraf Yükleyiniz',
          ctx: context,
        );

        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailTextController.text.trim().toLowerCase(),
          password: _passTextController.text.trim(),
        );
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child('$_uid.jpg');
        await ref.putFile(imageFile!);
        imageUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _fullNameController.text,
          'lastName': _lastNameController.text,
          'email': _emailTextController.text,
          'userImage': imageUrl,
          'phoneNumber': _phoneNumberController.text,
          'location': _locationController.text,
          'createdAt': Timestamp.now(),
        });
        // ignore: use_build_context_synchronously
        Navigator.canPop(context)
            ? Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserState()))
            : null;
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(9, 44, 10, 0),
                width: 371,
                height: 204,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/register.png"),
                        fit: BoxFit.cover))),
            Container(
              margin: EdgeInsets.only(top: 25, right: 164),
              child: AppText2(
                text: "Register",
                size: 36,
                fontWeight: FontWeight.w500,
              ),
            ),
            Form(
              key: _signUpFormKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showImageDialog();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: size.width * 0.24,
                        height: size.width * 0.24,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xff3F7DFD),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: imageFile == null
                                ? const Icon(
                                    Icons.camera_enhance_sharp,
                                    color: Color(0xff3F7DFD),
                                    size: 30,
                                  )
                                : Image.file(
                                    imageFile!,
                                    fit: BoxFit.fill,
                                  )),
                      ),
                    ),
                  ),
                  const Text(
                    'Click Icon to Create Profile Photo',
                    style: TextStyle(
                      color: Color(0xff3F7DFD),
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(33, 8, 14, 0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_lastnameFocusNode),
                      keyboardType: TextInputType.name,
                      controller: _fullNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Name';
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.black87),
                      decoration: const InputDecoration(
                          hintText: 'First Name',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  width: 1.0, color: Color(0xffE0E0E0))),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                          )),
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(33, 8, 14, 0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_emailFocusNode),
                      keyboardType: TextInputType.name,
                      controller: _lastNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your  Last Name';
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.black87),
                      decoration: const InputDecoration(
                          hintText: 'Last Name',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  width: 1.0, color: Color(0xffE0E0E0))),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                          )),
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(33, 8, 14, 0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_passFocusNode),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please Enter a Valid Email';
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.black87),
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  width: 1.0, color: Color(0xffE0E0E0))),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                          )),
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(33, 8, 14, 0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_locationFocusNode),
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passTextController,
                      obscureText: !_obscureText,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Lütfen Geçerli Bir Şifre Giriniz';
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black87,
                            ),
                          ),
                          hintText: 'Password',
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  width: 1.0, color: Color(0xffE0E0E0))),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.red,
                            ),
                          )),
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(33, 8, 14, 0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_phoneNumberFocusNode),
                      keyboardType: TextInputType.name,
                      controller: _locationController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your  Your Country';
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.black87),
                      decoration: const InputDecoration(
                          hintText: 'Please Enter Your Country',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  width: 1.0, color: Color(0xffE0E0E0))),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                          )),
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(33, 8, 14, 0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_phoneNumberFocusNode),
                      keyboardType: TextInputType.name,
                      controller: _phoneNumberController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Phone Number';
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.black87),
                      decoration: const InputDecoration(
                          hintText: 'Please Enter Your Phone Number',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  width: 1.0, color: Color(0xffE0E0E0))),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                          )),
                    ),
                  ),
                  if (_isLoading)
                    const Center(
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Container(
                      margin: const EdgeInsets.only(
                          left: 28, top: 30, right: 20, bottom: 95),
                      child: MaterialButton(
                        onPressed: () {
                          _submitFormOnSignUp();
                        },
                        child: ReUsableButton(
                            color: Color(0xff3F7DFD),
                            text: Container(
                                child: AppText(
                                    text: "Register",
                                    color: Colors.white,
                                    size: 20))),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
