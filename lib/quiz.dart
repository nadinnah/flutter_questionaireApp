import 'package:adv_basic1/data/questions.dart';
import 'package:adv_basic1/questions_screen.dart';
import 'package:adv_basic1/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:adv_basic1/start_screen.dart';


class Quiz extends StatefulWidget{
  const Quiz({super.key});

  @override
  State<Quiz> createState(){
  return _QuizState();
}
}

class _QuizState extends State<Quiz>{

  Widget? activeScreen;
  List<String> selectedAnswers=[];

  @override
  void initState() {
    activeScreen =  StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen(){
    setState((){
      activeScreen =  QuestionsScreen(onSelectedAnswer: chooseAnswer);

    });
  }

  void restartQuiz(){
    setState(() {
      selectedAnswers= [];
      activeScreen= QuestionsScreen(onSelectedAnswer: chooseAnswer);
    });

  }

  void chooseAnswer(String answer){
    selectedAnswers.add(answer);

    if(selectedAnswers.length == questions.length){
      setState(() {
        //selectedAnswers= [];
        activeScreen =   ResultsScreen(chosenAnswers: selectedAnswers,onRestart: restartQuiz,);
      });
    }
  }

 @override
  Widget build(context){
      
      if (activeScreen ==QuestionsScreen(onSelectedAnswer: chooseAnswer)) {
      activeScreen = QuestionsScreen(onSelectedAnswer: chooseAnswer);
    }
  
    if (activeScreen==  ResultsScreen(chosenAnswers: selectedAnswers,onRestart: restartQuiz,)){
      activeScreen =  ResultsScreen(chosenAnswers: selectedAnswers, onRestart: restartQuiz,);
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 54, 15, 54),
                Color.fromARGB(185, 158, 55, 148)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}