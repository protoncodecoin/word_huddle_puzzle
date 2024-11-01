import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:word_huddle_puzzle/wordle.dart';

class HuddleProvider extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> hurdleBoard = [];
  String targetWord = '';
  int count = 0;
  int index = 0;
  final lettersPerRow = 5;
  final totalAttempts = 6;
  int attempts = 0;
  bool wins = false;

  init() {
    totalWords = words.all.where((word) => word.length == 5).toList();
    generateBoard();
    generateRandomWord();
  }

  generateBoard() {
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ""));
  }

  generateRandomWord() {
    targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
    print(targetWord);
  }

  bool get isAValidWord =>
      totalWords.contains(rowInputs.join("").toLowerCase());

  bool get shouldCheckForAnswer => rowInputs.length == lettersPerRow;

  bool get noAttemptsLeft => attempts == totalAttempts;

  inputLetter(String letter) {
    if (count < lettersPerRow) {
      rowInputs.add(letter);
      count++;

      hurdleBoard[index] = Wordle(letter: letter);
      index++;

      notifyListeners();
    }
  }

  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeAt(rowInputs.length - 1);

      if (count > 0) {
        hurdleBoard[index - 1] = Wordle(letter: "");
        count--;
        index--;
      }
      notifyListeners();
    }
  }

  void checkAnswer() {
    final input = rowInputs.join("");
    if (input == targetWord) {
      wins = true;
    } else {
      _markLetterOnBoard();

      if (attempts < totalAttempts) {
        _goToNextRow();
      }
    }
  }

  void _markLetterOnBoard() {
    for (int i = 0; i < hurdleBoard.length; i++) {
      if (hurdleBoard[i].letter.isNotEmpty &&
          targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].existsInTarget = true;
      } else if (hurdleBoard[i].letter.isNotEmpty &&
          !targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].doesNotExistInTarget = true;
        excludedLetters.add(hurdleBoard[i].letter);
      }
    }

    notifyListeners();
  }

  void _goToNextRow() {
    attempts++;
    count = 0;
    rowInputs.clear();
  }

  reset() {
    count = 0;
    index = 0;
    attempts = 0;
    rowInputs = [];
    hurdleBoard = [];
    excludedLetters = [];
    wins = false;
    targetWord = "";
    generateBoard();
    generateRandomWord();

    notifyListeners();
  }
}
