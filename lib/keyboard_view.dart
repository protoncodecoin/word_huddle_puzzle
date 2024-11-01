import 'package:flutter/material.dart';

const keysList = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
];

class KeyboardView extends StatelessWidget {
  final List<String> excludedLetters;
  final Function(String) onPressed;
  const KeyboardView({
    super.key,
    required this.excludedLetters,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            for (int i = 0; i < keysList.length; i++)
              Row(
                children: keysList[i]
                    .map(
                      (element) => KeyWidget(
                        letter: element,
                        excluded: excludedLetters.contains(element),
                        onPress: (value) {
                          onPressed(value);
                        },
                      ),
                    )
                    .toList()
                //
                ,
              )
          ],
        ),
      ),
    );
  }
}

class KeyWidget extends StatelessWidget {
  final String letter;
  final bool excluded;
  final Function(String) onPress;

  const KeyWidget({
    super.key,
    required this.letter,
    this.excluded = false,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: excluded ? Colors.red : Colors.black,
            foregroundColor: Colors.white,
            padding: EdgeInsets.zero),
        onPressed: () {
          onPress(letter);
        },
        child: Text(letter),
      ),
    );
  }
}
