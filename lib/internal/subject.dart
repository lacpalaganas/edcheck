class Subjects {
  //math is the only subject for now
  static final List<String> subjects = ['Math'];

  List<String> getListOfSubjects() {
    return subjects;
  }

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(subjects);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
