import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mcq/models/user_model.dart';
import 'package:mcq/screens/quiz_screen.dart';
import 'package:mcq/services/app_language.dart';
import 'package:mcq/services/size_config.dart';
import 'package:get/get.dart';
import 'package:mcq/services/theme_services.dart';
import 'package:mcq/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String email, password, cPassword, name, phone;
  final formKey = GlobalKey<FormState>(); //key for form

  GoogleSignInAccount? _currentUser;

  //AccessToken? _accessToken;
  UserModel? currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;
    SizeConfig().init(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              child: Column(children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "SignUp".tr,
                    style: bigHeadingStyle,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight / 50),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: "Enter your name",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "cName".tr;
                    } else {
                      setState(() {
                        name = value;
                      });
                    }
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight / 50),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: "Enter your number",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                            .hasMatch(value)) {
                      return "cNumber".tr;
                    } else {
                      setState(() {
                        phone = value;
                      });
                    }
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight / 50),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: "Enter your email",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                            .hasMatch(value)) {
                      return "cEmail".tr;
                    } else {
                      setState(() {
                        email = value;
                      });
                    }
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight / 50),
                TextFormField(
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Enter your password",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "cPassword".tr;
                    } else {
                      setState(() {
                        password = value;
                      });
                    }
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight / 50),
                TextFormField(
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Confirm your password",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty || value != password) {
                      return "CconfirmPassword".tr;
                    } else {
                      setState(() {
                        cPassword = value;
                      });
                    }
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight / 50),
                Container(
                  width: SizeConfig.screenWidth,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          // side: BorderSide(color: Primary)
                        ))),
                    child: Text(
                      "sign_up".tr,
                      style: subTitleStyle,
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            message: 'submitting'.tr,
                          ),
                        );
                        print(name +
                            " " +
                            phone +
                            " " +
                            email +
                            " " +
                            password +
                            " " +
                            cPassword);
                        await Get.to(() => QuizScreen());
                      }
                      //await Get.to(() => QuizScreen());
                    },
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight / 50),
                Container(
                  child: Text("signup_using".tr, style: bodyStyle),
                ),
                SizedBox(height: SizeConfig.screenHeight / 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.only(top: 10),
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.redAccent,
                      ),
                      iconSize: 55,
                      onPressed: signInGoogle,
                    ),
                    SizedBox(width: SizeConfig.screenWidth / 7),
                    IconButton(
                      icon: const Icon(
                        Icons.facebook_rounded,
                        color: Colors.blue,
                      ),
                      iconSize: 65,
                      onPressed: signOutGoogle /*(){}signInFacebook*/,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight / 30),
              ]),
            ),
          ),
        ));
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      actions: [
        GetBuilder<AppLanguage>(
          init: AppLanguage(),
          builder: (controller) {
            return DropdownButton(
              items: const [
                DropdownMenuItem(
                  child: Text('En'),
                  value: 'en',
                ),
                DropdownMenuItem(
                  child: Text('Ar'),
                  value: 'ar',
                ),
              ],
              value: controller.appLocal,
              onChanged: (value) {
                controller.changeLanguage(value.toString());
                Get.updateLocale(Locale(value.toString()));
              },
            );
          },
        ),
        IconButton(
          onPressed: () {
            ThemeServices().switchTheme();
          },
          icon: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_outlined,
            size: 24,
            color: Get.isDarkMode ? white : darkGreyClr,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Future<void> signInGoogle() async {
    try {
      await _googleSignIn.signIn();
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: 'submitting'.tr,
        ),
      );
      print(_currentUser?.email);
      await Get.to(() => QuizScreen());
    } catch (e) {
      print('Error signIn in $e');
    }
  }

  void signOutGoogle() {
    _googleSignIn.disconnect();
  }


//   Future<void> signInFacebook() async {
//     final LoginResult result = await FacebookAuth.instance
//         .login(); // by default we request the email and the public profile
// // or FacebookAuth.i.login()
//     if (result.status == LoginStatus.success) {
//       // you are logged
//       final AccessToken accessToken = result.accessToken!;
//     } else {
//       print(result.status);
//       print(result.message);
//     }
//     final data = await FacebookAuth.i.getUserData();
//     UserModel userModel = UserModel.fromMap(data);
//     currentUser = userModel;
//     //--------------------------
//     print(currentUser?.email);
//   }
}
