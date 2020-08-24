import 'package:design_by_me/models/font_file_model.dart';

class FontData {
  // final int userId;
  // final int id;
  // final String title;
  // final String body;
  final String family;
  final String category;
  final List variants;
  final List subsets;
  final FontFileData fontFileData;

  //final make a dataObject of files the ttf file

  FontData(
      {this.family,
      this.category,
      this.variants,
      this.subsets,
      this.fontFileData});
//factory is method to or a design pattern - data will stay static

  factory FontData.fromJson(Map<dynamic, dynamic> json,
      {fontFileData} /*DateTime dateTime */) {
    return FontData(
        family: json['family'],
        category: json['category'],
        variants: json['variants'],
        subsets: json['subsets'],
        fontFileData: FontFileData.fromJson(json['files'])
        // lastModified: dateTime
        );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'family': family,
      'category': category,
      'variants': variants,
      'subsets': subsets,
      'files': fontFileData.fileDataToJson()
    };
  }
}
