import 'package:hive/hive.dart';

class Note {
  String id;
  String title;

  Note(this.id, this.title);

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];

  // method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
