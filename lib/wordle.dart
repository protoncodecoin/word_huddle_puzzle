class Wordle {
  String title;
  bool existsInTarget;
  bool doesNotExistInTarget;

  Wordle({
    required this.title,
    this.existsInTarget = false,
    this.doesNotExistInTarget = false,
  });
}
