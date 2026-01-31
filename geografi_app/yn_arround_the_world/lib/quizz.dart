import 'package:flutter/material.dart';
import 'settings.dart';
import 'quiz_question.dart';

// screen for the quiz (stateful because question and score change)
class Quizz extends StatefulWidget {
  final String country;
  const Quizz({super.key, required this.country});

  @override
  State<Quizz> createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswer;
  bool showResult = false;

  // track achivements
  bool friendUnlocked = false;
  bool souvenirUnlocked = false;

  /// all questions in the quiz
  // CHANGE INDEXES !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  final List<QuizQuestion> questionsEgypt = [
    // EGYPT
    QuizQuestion(
      question: 'What is the countrys world wonder?',
      answers: ['Pyramids of Giza', 'Sphinx of Giza', 'Valley of the Kings'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the countrys capital city?',
      answers: ['Cairo', 'Giza', 'Alexandria'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the longest river in the world?',
      answers: ['Nile', 'Tributaries', 'Wadis'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the national dish of Egypt?',
      answers: ['Koshari', 'Shawarma', 'Falafel'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question:
          'What animal has a massive population due to historical significance?',
      answers: ['Cat', 'Pigeon', 'Nile Crocodile'],
      correctIndex: 0,
    ),
  ];
  final List<QuizQuestion> questionsMexico = [
    // MEXICO
    QuizQuestion(
      question: 'What is the countrys world wonder?',
      answers: ['Chichen Itza', 'Machu Picchu', 'Coba'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the countrys capital city?',
      answers: ['Mexico City', 'Chihuahua', 'Cancún'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the tallest mountain?',
      answers: ['Pico de Orizaba', 'Matlalcueitl', 'Iztaccihuatl'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'What is a native way of celebrating special occasions?',
      answers: ['Mariachi', 'Piñata', 'Eat leche flan'],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: 'What food originated in Mexico?',
      answers: ['Chocolate', 'Coffee', 'Churros'],
      correctIndex: 0,
    ),
  ];
  final List<QuizQuestion> questionsChina = [
    // CHINA
    QuizQuestion(
      question: 'What is the countrys world wonder?',
      answers: [
        'The Great Wall of China',
        'Zhangjiajie National Forest Park',
        'Zhujiajiao Ancient Watertown',
      ],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the country’s capital city?',
      answers: ['Beijing', 'Shanghai', 'Guangzhou'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the longest river in China?',
      answers: ['Yangtze River', 'Huanghe River', 'Zhujiang River'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'What is the name of Luo Yan’s cultural clothing?',
      answers: ['Qipao', 'Kimono', 'Hanbok'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'How many time zones are in China?',
      answers: ['5', '6', '7'],
      correctIndex: 0,
    ),
  ];

  List<QuizQuestion> get questions {
    if (widget.country == 'Egypt') {
      List<QuizQuestion> listofquestions = questionsEgypt;
      return listofquestions;
    } else if (widget.country == 'China') {
      List<QuizQuestion> listofquestions = questionsChina;
      return listofquestions;
    } else {
      List<QuizQuestion> listofquestions = questionsMexico;
      return listofquestions;
    }
  }

  // when you select an awnser it tells you whether you are correct
  // and adds points to your score
  void selectAnswer(int index) {
    setState(() {
      selectedAnswer = index;
      showResult = true;

      // when correct add 25 points
      if (index == questions[currentQuestionIndex].correctIndex) {
        score += 25;
      }

      // get rewards based on the score
      if (score >= 50) {
        friendUnlocked = true;
      }
      if (score >= 150) {
        souvenirUnlocked = true;
      }

      // ADD THE LAST ACHIVEMENT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    });
  }

  // go to next question and resets the showResult and selectedAnswer
  void nextQuestion() {
    setState(() {
      showResult = false;
      selectedAnswer = null;
      currentQuestionIndex++;
    });
  }

  // resets everything back to the start
  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      selectedAnswer = null;
      showResult = false;
      friendUnlocked = false;
      souvenirUnlocked = false;
    });
  }

  // pics the question based on the index
  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    // builds the quiz screen (how it looks)
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 1.0,
        title: const Text(
          'y/n arround the world',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('not available yet')),
              );
            },
            icon: Icon(Icons.emoji_people),
            tooltip: 'Friend list',
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('not available yet')),
              );
            },
            icon: Icon(Icons.shopping_bag),
            tooltip: 'Shop',
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('not available yet')),
              );
            },
            icon: Icon(Icons.person),
            tooltip: 'My account',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              // quiz on the left
              Expanded(
                flex: 3,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Time to see what you learned',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text(
                          question.question,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 24),

                        RadioGroup<int?>(
                          groupValue: selectedAnswer,
                          onChanged: (int? newValue) {
                            if (showResult) return;
                            selectAnswer(newValue!);
                          },
                          child: Column(
                            children: List.generate(
                              question.answers.length,
                              (index) => ListTile(
                                title: Text(question.answers[index]),
                                leading: Radio<int?>(value: index),
                              ),
                            ),
                          ),
                        ),

                        if (showResult)
                          Text(
                            selectedAnswer == question.correctIndex
                                ? 'Correct!'
                                : 'Wrong answer',
                            style: TextStyle(
                              color: selectedAnswer == question.correctIndex
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),

                        const Spacer(),

                        // shows correct or wrong
                        if (showResult)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              // if there are more questions the next button is there otherwise repeat quiz
                              onPressed:
                                  currentQuestionIndex < questions.length - 1
                                  ? nextQuestion
                                  : resetQuiz,
                              child: Text(
                                currentQuestionIndex < questions.length - 1
                                    ? 'Next'
                                    : 'Repeat Quiz',
                              ),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'End Quiz',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 24),

              // results
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    if (friendUnlocked)
                      const RewardTile(
                        icon: Icons.person_add,
                        text: 'New friend unlocked!',
                      ),
                    if (souvenirUnlocked)
                      const RewardTile(
                        icon: Icons.card_giftcard,
                        text: 'Souvenir earned!',
                      ),
                    RewardTile(icon: Icons.star, text: 'Score: $score'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RewardTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const RewardTile({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(text),
      ),
    );
  }
}
