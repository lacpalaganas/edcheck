class Schools {
  static final List<String> schools = [
    'East Los Angeles College',
    'Los Angeles City College',
    'Los Angeles Harbor College',
    'Los Angeles Mission College',
    'Los Angeles Pierce College',
    'Los Angeles Southwest College',
    'L.A. Trade-Tech College',
    'Los Angeles Valley College',
    'West Los Angeles College',
  ];

  List<String> getListOfSchools() {
    return schools;
  }

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(schools);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
