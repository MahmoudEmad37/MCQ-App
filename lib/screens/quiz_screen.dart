import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/quiz_brain.dart';
import 'package:mcq/services/app_language.dart';
import 'package:mcq/services/theme_services.dart';
import 'package:mcq/theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Icon> scoreKeeper = [];
  QuizBrain quizBrain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: headingStyle,
                  ),
                ),
              ),
            ),
            buildChoice(quizBrain.getAnswer1()),
            buildChoice(quizBrain.getAnswer2()),
            buildChoice(quizBrain.getAnswer3()),
            buildChoice(quizBrain.getAnswer4()),
            Expanded(
              child: Row(
                children: scoreKeeper,
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded buildChoice(String answer) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(blueGrey),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)))),
          child: Text(
            answer,
            style: titleStyle,
          ),
          onPressed: () {
            checkAnswer(answer);
          },
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          size: 24,
          color: Get.isDarkMode ? white : darkGreyClr,
        ),
        onPressed:()=> Get.back(),
      ),
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

  void checkAnswer(String userPickedAnswer) {
    String correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
            context: context,
            title: "result".tr,
            desc:
                "scored".tr+" ${((quizBrain.getResult() / 10) * 100).toInt()} %",
            image: Image.asset("assets/images/result.png",),
            style: AlertStyle(
              animationType: AnimationType.fromTop,
              isCloseButton: false,
              isOverlayTapDismiss: false,
              descStyle: const TextStyle(fontWeight: FontWeight.bold),
              descTextAlign: TextAlign.start,
              animationDuration: const Duration(milliseconds: 400),
              alertBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: const BorderSide(color: grey),
              ),
              titleStyle: const TextStyle(color: Primary),
              alertAlignment: Alignment.center,
            ),
            buttons: [
              DialogButton(
                color: bluishClr,
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "OK",
                  style: TextStyle(color: white, fontSize: 20),
                ),
              ),
            ]).show();
        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
          quizBrain.addResult();
        } else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }
}
