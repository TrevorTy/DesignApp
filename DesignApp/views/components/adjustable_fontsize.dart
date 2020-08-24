import 'package:design_by_me/models/font_file_model.dart';
import 'package:flutter/material.dart';

class UISettings {
  final double fontSize;
  final double lineHeight;
  final FontWeightData fontWeightData;
  final Color backgroundColor;
  final Color textColor;

  UISettings(
      {this.backgroundColor,
      this.textColor,
      this.fontSize = 30.0,
      this.lineHeight = 1.0,
      this.fontWeightData});

  UISettings copyWith(
      {double fontSize,
      double lineHeight,
      FontWeightData fontWeightData,
      Color backgroundColor,
      Color textColor}) {
    return UISettings(
        fontSize: fontSize ?? this.fontSize,
        lineHeight: lineHeight ?? this.lineHeight,
        fontWeightData: fontWeightData ?? this.fontWeightData,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textColor: textColor ?? this.textColor);
  }
}

class AdjustableFontSizeText extends StatelessWidget {
  AdjustableFontSizeText(this.text,
      {this.stream,
      this.fontColor,
      this.fontFamily,
      this.initialValue,
      this.fontSize,
      this.fontHeight});

  final Stream<UISettings> stream;
  final Color fontColor;
  final String fontFamily;
  final String text;
  final UISettings initialValue;
  final double fontSize;
  final double fontHeight;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UISettings>(
      stream: stream,
      initialData: initialValue,
      builder: (BuildContext context, AsyncSnapshot<UISettings> snapshot) {
        return Text(
          text,
          style: TextStyle(
              fontWeight: snapshot.data.fontWeightData?.convertToFontWeight() ??
                  FontWeight.normal,
              fontStyle: snapshot.data.fontWeightData?.convertToFontStyle() ??
                  FontStyle.normal,
              height: this.fontHeight ?? snapshot.data.lineHeight,
              fontFamily: fontFamily,
              color: fontColor,
              fontSize: this.fontSize ?? snapshot.data.fontSize),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        );
      },
    );
  }
}
