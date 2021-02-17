class AddTripDM {
  String title;
  String description;

  AddTripDM({this.title, this.description});

  factory AddTripDM.fromMap(Map data) {
    return AddTripDM(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
      {"title": title, "description": description};
}