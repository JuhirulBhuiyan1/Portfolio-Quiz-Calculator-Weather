import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal, Colors.blue],
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Start Quiz',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;

  List<Map<String, dynamic>> questions = [
    {
      'category': 'Geography',
      'question': 'What is the capital of Japan?',
      'options': ['Beijing', 'Seoul', 'Tokyo', 'Bangkok'],
      'correctAnswer': 'Tokyo',
    },
    {
      'category': 'Science',
      'question': 'What is the largest planet in our solar system?',
      'options': ['Mars', 'Jupiter', 'Saturn', 'Earth'],
      'correctAnswer': 'Jupiter',
    },
    {
      'category': 'History',
      'question': 'In which year did World War II end?',
      'options': ['1943', '1945', '1950', '1939'],
      'correctAnswer': '1945',
    },
    {
      'category': 'Mathematics',
      'question': 'What is the square root of 144?',
      'options': ['10', '12', '14', '16'],
      'correctAnswer': '12',
    },
    {
      'category': 'General Knowledge',
      'question': 'Which country is known as the Land of the Rising Sun?',
      'options': ['China', 'India', 'Japan', 'Australia'],
      'correctAnswer': 'Japan',
    },
    {
      'category': 'Technology',
      'question': 'Who is the co-founder of Microsoft?',
      'options': ['Steve Jobs', 'Bill Gates', 'Mark Zuckerberg', 'Elon Musk'],
      'correctAnswer': 'Bill Gates',
    },
    // Add more questions...
  ];

  void _checkAnswer(String selectedAnswer) {
    String correctAnswer = questions[_currentIndex]['correctAnswer'];
    bool isCorrect = selectedAnswer == correctAnswer;

    if (isCorrect) {
      _score++;
    }

    _nextQuestion();
  }

  void _nextQuestion() {
    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: _score, questions: questions),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App - ${questions[_currentIndex]['category']} - Question ${_currentIndex + 1}'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.lightBlue],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                questions[_currentIndex]['question'],
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Column(
                children: List.generate(
                  questions[_currentIndex]['options'].length,
                      (index) {
                    return ElevatedButton(
                      onPressed: () {
                        _checkAnswer(questions[_currentIndex]['options'][index]);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        questions[_currentIndex]['options'][index],
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final List<Map<String, dynamic>> questions;

  ResultScreen({required this.score, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal, Colors.blue],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your Score: $score',
                style: TextStyle(color: Colors.white),
              ),
              _getFeedback(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Restart Quiz',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getFeedback() {
    if (score == questions.length) {
      return Text(
        'Congratulations! You answered all questions correctly.',
        style: TextStyle(color: Colors.white),
      );
    } else if (score >= questions.length ~/ 2) {
      return Text(
        'Good job! You scored $score out of ${questions.length} questions.',
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Text(
        'Keep practicing. You scored $score out of ${questions.length} questions.',
        style: TextStyle(color: Colors.white),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: AuthScreen(),
    theme: ThemeData(
      primarySwatch: Colors.teal,
    ),
  ));
}
