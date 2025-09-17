import 'dart:convert';


class NoteModel {
  
String? title;

String? subTitle;

String? description;

String date;

List<String>? imagePath; 

String? videoPath;

int? primaryKey;


static const String table_name= 'user_data' ;
static const String col_title= 'title';
static const String col_subTitle= 'sub_title';
static const String col_description= 'description';
static const String col_imagePath= 'image_path';
static const String col_videoPath= 'video_path';
static const String col_key= 'p_key';
static const String col_date= 'date_';

static const CREATE_TABLE= '''CREATE TABLE IF NOT EXISTS $table_name (
$col_key INTEGER PRIMARY KEY AUTOINCREMENT,
$col_title text,
$col_subTitle text,
$col_imagePath text,
$col_videoPath text,
$col_description text,
$col_date text
)''';


  NoteModel({
    this.title,
    this.subTitle,
    this.description,
    required this.date,
    this.imagePath,
    this.videoPath,
    this.primaryKey,
  });





  Map<String, dynamic> toMap() {
    return {
      col_title :title,
      col_subTitle: subTitle,
      col_description: description,
      col_date: date,
      col_imagePath: jsonEncode(imagePath),
      col_videoPath: videoPath,
      col_key : primaryKey,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map[col_title],
      subTitle: map[col_subTitle],
      description: map[col_description],
      date: map[col_date] ?? '',
       imagePath: map[col_imagePath] != null
          ? List<String>.from(jsonDecode(map[col_imagePath]))
          : null,
      videoPath: map[col_videoPath],
      primaryKey: map[col_key]?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) => NoteModel.fromMap(json.decode(source));

}
