class Task {
  final String title;
  final String date;
  final String time;
  bool status = true;

  Task({required this.title, required this.date, required this.time});

  void toggleStatus() {
    status = !status;
  }
}
