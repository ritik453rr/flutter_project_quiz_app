import 'package:quiz/model/question_model.dart';

List<QuestionModel> questions = [
  QuestionModel("Dart is primarily used for?",{
      "Data Analysis":false,
      "Game Development":false,
      "Web and Mobile app Development":true,
      "Machine Learning":false,
    }
    ),
    QuestionModel(
    "Which keyword is used to define a constant in dart?",{
      "var":false,
      "final":false,
      "const":true,
      "let":false,
    },
  ),
   QuestionModel(
    "What is the purpose of the 'main()' in dart?",{
      "Entry point of the program":true,
      "Declaring a variable":false,
      "Define a class":false,
      "All of the the above":false,
    },
  ),
  QuestionModel(
    "Which data type is used for holding integer value in dart?",{
      "String":false,
      "int":true,
      "var":false,
      "bool":false,
    },
  ),
  QuestionModel(
    "In dart what does the 'async' keyword indicates?",{
      "A function that returns a Future":true,
      "A keyword for defining class":false,
      "A type of loop":false,
      "A function that runs synchronously":false,
    },
  ),
  QuestionModel(
    "what is the latest version of dart?",{
      "2.3":false,
      "3.5":false,
      "3.2":true,
      "5.3":false,
    },
  ),
  QuestionModel(
    "what does the '=>' syntax represent in dart?",{
      "Assignment Operator":false,
      "Function arrow syntax":true,
      "Bitwise operator ":false,
      "Ternary Operator":false,
    },
  ),
  QuestionModel(
    "How do you import a library in dart?",{
      "import('library.dart')":false,
      "include 'library.dart'":false,
      "import 'library.dart'":true,
      "import dart.library":false,
    },
  ),
   QuestionModel(
    "Which of the folowing is used to conditional rendering in dart?",{
      "Switch Case":false,
      "if-else":true,
      "while loop":false,
      "for loop":false,
    },
  ),
  QuestionModel(
    "Dart is devoloped by?",{
      "Apple":false,
      "Microsoft":false,
      "Google":true,
      "Meta":false,
    },
  ),
];
