import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_huddle_puzzle/huddle_provider.dart';

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
    );
  }
}
