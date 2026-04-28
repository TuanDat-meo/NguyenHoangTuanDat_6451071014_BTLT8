class WordModel {
  final int? id;
  final String word;
  final String meaning;

  WordModel({this.id, required this.word, required this.meaning});

  Map<String, dynamic> toMap() => {
    'id': id,
    'word': word,
    'meaning': meaning,
  };

  factory WordModel.fromMap(Map<String, dynamic> map) => WordModel(
    id: map['id'],
    word: map['word'],
    meaning: map['meaning'],
  );
}