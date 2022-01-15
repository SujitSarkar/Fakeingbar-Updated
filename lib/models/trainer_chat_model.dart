class TrainerChatModel {
  int? id;
  String? question;
  String? answer;

  TrainerChatModel({
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map["id"] = id;
    }
    map["question"] = question;
    map["answer"] = answer;

    return map;
  }

  TrainerChatModel.fromMapObject(Map<String, dynamic> map) {
    id = map["id"];
    question = map['question'];
    answer = map["answer"];
  }
  TrainerChatModel copyWith({
    String? question,
    String? answer,
  }) {
    return TrainerChatModel(
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }
}
