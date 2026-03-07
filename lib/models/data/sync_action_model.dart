class SyncAction {
  String id;
  String type;
  Map payload;
  int retry;

  SyncAction({
    required this.id,
    required this.type,
    required this.payload,
    this.retry = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "payload": payload,
      "retry": retry
    };
  }

  factory SyncAction.fromJson(Map data) {
    return SyncAction(
      id: data["id"],
      type: data["type"],
      payload: Map<String, dynamic>.from(data["payload"]),
      retry: data["retry"] ?? 0,
    );
  }
}