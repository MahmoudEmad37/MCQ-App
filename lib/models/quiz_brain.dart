import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _result=0;

  final List<Question> _questionBank = [
    Question('The average of first 50 natural numbers is ………….','25.30','25.5','25.00','12.25','25.5' ),
    Question('The number of 3-digit numbers divisible by 6, is ………….','149','166','150','151','150' ),
    Question('What is 1004 divided by 2 ?','52','502','520','5002','502' ),
    Question('106 × 106 – 94 × 94 = ','2004','2400','1904','1906','2400' ),
    Question('Which of the following numbers gives 240 when added to its own square ','15','16','18','20','15' ),
    Question('Evaluation of 83 × 82 × 8-5 is ………….','1','0','8','None of these','1' ),
    Question('The simplest form of 1.5 : 2.5 is …………….','6 : 10','15 : 25',' 0.75 : 1.25','3 : 5','3 : 5'),
    Question('ما هو أكبر عدد مكون من رقمين؟','10','90','11','99','99' ),
    Question('ما هو ناتج 90-19؟','71','109','89','None of these','71' ),
    Question('ما هو الرقم الذي يقبل 20 القسمة عليه؟','1','3','7','None of these','1' ),
  ];

  late final List<Question> _question =_questionBank..shuffle();

  void nextQuestion() {
    if (_questionNumber < _question.length - 1) {
      _questionNumber++;
    }
  }

  int getResult(){
    return _result;
  }

  addResult() {
    _result = _result+1;
  }

  String getQuestionText() {
    return _question[_questionNumber].questionText!;
  }

  String getQuestionAnswer() {
    return _question[_questionNumber].questionAnswer!;
  }

  String getAnswer1(){
    return _question[_questionNumber].answer1!;
  }
  String getAnswer2(){
    return _question[_questionNumber].answer2!;
  }
  String getAnswer3(){
    return _question[_questionNumber].answer3!;
  }String getAnswer4(){
    return _question[_questionNumber].answer4!;
  }


  bool isFinished() {
    if (_questionNumber >= _question.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
    _result=0;
  }
}
