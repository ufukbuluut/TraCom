import 'package:flutter/material.dart';
import 'package:tracom/screens/welcome_page_tourist.dart';
import 'package:tracom/widgets/AppText.dart';
import 'package:tracom/widgets/AppText2.dart';
import 'package:tracom/widgets/ReUsableButton.dart';
import 'package:tracom/widgets/ReUsableTextFormField.dart';
import '../Services/global_variables.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tracom/Services/global_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  final TextEditingController _emailTextController =
      TextEditingController(text: '');
  final TextEditingController _passTextController =
      TextEditingController(text: '');

  FocusNode _passFocusNode = FocusNode();
  bool _isLoading = false;
  bool _obscureText = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _animationController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  void _submitFormOnLogin() async {
    final isValid = _loginFormKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailTextController.text.trim().toLowerCase(),
          password: _passTextController.text.trim(),
        );
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
        print('Hata Oluştu $error');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: guidesImage2,
            placeholder: (context, url) => Image.asset(
              'img/LOGO.jpeg',
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Container(
            color: Colors.black38,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Image.asset('img/tracom.png'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        Container(
                          width: 343,
                          height: 60,
                          margin: EdgeInsets.fromLTRB(24, 19, 23, 0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passFocusNode),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide:
                                      BorderSide(width: 1.0, color: Colors.red),
                                )),
                          ),
                        ),
                        Container(
                          width: 343,
                          height: 60,
                          margin: EdgeInsets.fromLTRB(24, 19, 23, 0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: _passFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passTextController,
                            obscureText:
                                !_obscureText, // Dinamik Şekilde değiştirme
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please Enter a Valid Password';
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Colors.red,
                                  ),
                                )),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 18, top: 12, right: 255),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WelcomePageTourist()));
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: Color(0xff57C3FF),
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic),
                                )),
                          ),
                        ),
                        MaterialButton(
                          onPressed: _submitFormOnLogin,
                          child: ReUsableButton(
                              color: Color(0xff4B93FF),
                              text: Container(
                                  child: AppText(
                                      text: "Log in",
                                      color: Colors.white,
                                      size: 20))),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Center(
                          child: RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                              text: "Don't Have an Account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const TextSpan(text: '      '),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WelcomePageTourist())),
                                text: 'Create an Account',
                                style: const TextStyle(
                                  color: Color(0xff4B93FF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ))
                          ])),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
