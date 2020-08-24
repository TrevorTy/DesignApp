import 'dart:core';

import 'package:flutter/material.dart';

class FontFileData {
  final List<FontWeightData> fontWeights;

//regular
  final String regular;
  final String regular100;
  final String regular200;
  final String regular300;
  final String regular400;
  final String regular500;
  final String regular600;
  final String regular700;
  final String regular800;
  final String regular900;
//italic
  final String italic;
  final String italic100;
  final String italic200;
  final String italic300;
  final String italic400;
  final String italic500;
  final String italic600;
  final String italic700;
  final String italic800;
  final String italic900;

  FontFileData(
      {this.fontWeights,
      this.regular,
      this.regular100,
      this.regular200,
      this.regular300,
      this.regular400,
      this.regular500,
      this.regular600,
      this.regular700,
      this.regular800,
      this.regular900,
      this.italic,
      this.italic100,
      this.italic200,
      this.italic300,
      this.italic400,
      this.italic500,
      this.italic600,
      this.italic700,
      this.italic800,
      this.italic900});
//factory is method to or a design pattern - data will stay static
//with CopyWith you can change

  factory FontFileData.fromJson(Map<dynamic, dynamic> json) {
    List<FontWeightData> list = [];
    json.forEach((key, value) {
      list.add(FontWeightData(name: key, url: value));
    });

    return FontFileData(
      fontWeights: list,
      regular: json['regular'],
      regular100: json['100'],
      regular200: json['200'],
      regular300: json['300'],
      regular400: json['400'],
      regular500: json['500'],
      regular600: json['600'],
      regular700: json['700'],
      regular800: json['800'],
      regular900: json['900'],
      italic: json['italic'],
      italic100: json['100italic'],
      italic200: json['200italic'],
      italic300: json['300italic'],
      italic400: json['400italic'],
      italic500: json['500italic'],
      italic600: json['600italic'],
      italic700: json['700italic'],
      italic800: json['800italic'],
      italic900: json['900italic'],
    );
  }

  //make an object an get the name and the url of that Json object

  //Show the fontData if its not null and in an array
  //FontFileData.fromJson(json)

  //  Map<String, dynamic>toJson () {
  // return {'family': family,
  // 'category' : category,
  // 'variants' : variants,
  // 'subsets' : subsets,
  // 'fontFileData' : fontFileData.toJson()
  // };

  Map<dynamic, dynamic> fileDataToJson() {
    return {'regular': regular};
  }
}

class FontWeightData {
  FontWeight convertToFontWeight() {
    switch (name) {
      case '100':
      case 'italic100':
      case 'regular100':
        return FontWeight.w100;
        break;
      case '200':
      case 'italic200':
      case 'regular200':
        return FontWeight.w200;
        break;
      case '300':
      case 'italic300':
      case 'regular300':
        return FontWeight.w300;
        break;
      case '400':
      case 'italic400':
      case 'regular400':
        return FontWeight.w400;
        break;
      case '500':
      case 'italic500':
      case 'regular500':
        return FontWeight.w500;
        break;
      case '600':
      case 'italic600':
      case 'regular600':
        return FontWeight.w600;
        break;
      case '700':
      case '700italic':
      case '700regular':
        return FontWeight.w700;
        break;
      case '800':
      case 'italic800':
      case 'regular800':
        return FontWeight.w800;
        break;
      case '900':
      case 'italic900':
      case 'regular900':
        return FontWeight.w900;
        break;
      default:
        return FontWeight.normal;
        break;
    }
  }

//check if it contains italic and send it back
  FontStyle convertToFontStyle() {
    if (name.toString().contains('italic')) {
      {
        return FontStyle.italic;
      }
    } else {
      return FontStyle.normal;
    }
    //if name contains italic send italic back
  }

  FontWeightData({this.name, this.url});
  final String name;
  final String url;
}
