import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_huddle_puzzle/huddle_provider.dart';
import 'package:word_huddle_puzzle/keyboard_view.dart';
import 'package:word_huddle_puzzle/wordle_view.dart';

class WordHuddlePage extends StatefulWidget {
  const WordHuddlePage({super.key});

  @override
  State<WordHuddlePage> createState() => _WordHuddlePageState();
}

class _WordHuddlePageState extends State<WordHuddlePage> {
  @override
  void didChangeDependencies() {
    Provider.of<HuddleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Huddle"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Consumer<HuddleProvider>(
                  builder: (context, provider, child) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4),
                    itemCount: provider.hurdleBoard.length,
                    itemBuilder: (context, index) {
                      final wordle = provider.hurdleBoard[index];

                      return WordleView(wordle: wordle);
                    },
                  ),
                ),
              ),
            ),
            Consumer<HuddleProvider>(
              builder: (context, provider, child) => KeyboardView(
                excludedLetters: provider.excludedLetters,
                onPressed: (value) {
                  provider.inputLetter(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
