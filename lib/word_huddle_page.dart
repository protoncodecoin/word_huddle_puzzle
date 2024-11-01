import 'package:flutter/material.dart';

class WordHuddlePage extends StatefulWidget {
  const WordHuddlePage({super.key});

  @override
  State<WordHuddlePage> createState() => _WordHuddlePageState();
}

class _WordHuddlePageState extends State<WordHuddlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Huddle"),
      ),
    );
  }
}
