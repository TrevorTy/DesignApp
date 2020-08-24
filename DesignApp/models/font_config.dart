import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_by_me/models/font_data_model.dart';

class FontConfig {
  final String id;
  final FontData fontData;
  final String userId;
  final String backGroundColor;
  final String fontColor;
  final Timestamp date;
  final String quote;

  FontConfig(
      {this.id,
      this.fontData,
      this.userId,
      this.backGroundColor,
      this.date,
      this.fontColor,
      this.quote});

  factory FontConfig.fromJson(Map<dynamic, dynamic> json, String id) {
    return FontConfig(
        fontData: FontData.fromJson(json['fontData']),
        userId: json['userId'],
        backGroundColor: json['backGroundColor'],
        fontColor: json['fontColor'],
        date: json['date'],
        quote: json['quote'],
        id: id);
  }

  static List<FontConfig> parseList(QuerySnapshot snapshot) {
    if (snapshot.documents.isEmpty) {
      return [];
    }

    return List<FontConfig>.from(snapshot.documents.map((docmentSnapshot) {
      return FontConfig.fromJson(
          docmentSnapshot.data, docmentSnapshot.documentID);
    }));
  }
}
