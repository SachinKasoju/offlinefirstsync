class Note {
  String id;
  String title;
  bool liked;
  String syncStatus;
  DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    this.liked = false,
    this.syncStatus = "pending",
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "liked": liked,
      "syncStatus": syncStatus,
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  factory Note.fromJson(Map data) {
    return Note(
      id: data["id"],
      title: data["title"],
      liked: data["liked"],
      syncStatus: data["syncStatus"],
      updatedAt: DateTime.parse(data["updatedAt"]),
    );
  }
}