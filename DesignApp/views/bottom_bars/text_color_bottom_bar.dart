import 'package:design_by_me/views/components/lockable_slider.dart';
import 'package:design_by_me/_utils/color_generator.dart';
import 'package:design_by_me/controllers/font_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextColorBottomBarView extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final Function changeTextView;
  final Function textColorChanged;

  TextColorBottomBarView(
      {Key key,
      @required this.backgroundColor,
      @required this.textColor,
      this.changeTextView,
      this.textColorChanged})
      : super(key: key);

  @override
  _TextColorBottomBarViewState createState() => _TextColorBottomBarViewState();
}

class _TextColorBottomBarViewState extends State<TextColorBottomBarView> {
  bool _redTextIsUnlocked = true;
  bool _greenTextIsUnlocked = true;
  bool _blueTextIsUnlocked = true;
  Color _textColor;
  int _textRed;
  int _textGreen;
  int _textBlue;
  double _opacity = 1;
  bool isExpanded = false;

  @override
  void initState() {
    _textColor = widget.textColor;
    _textRed = widget.textColor.red;
    _textGreen = widget.textColor.green;
    _textBlue = widget.textColor.blue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FontController fontController = Provider.of<FontController>(context);
    ColorGenerator colorController = Provider.of<ColorGenerator>(context);

    return Container(
      // color: backgroundColor,
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(30), color: backgroundColor),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: widget.backgroundColor),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          SizedBox(
            height: 10,
          ),
          LockableSlider(
            lockchanged: (val) {
              _redTextIsUnlocked = val;
            },
            colorName: "Red",
            value: _textRed.toDouble(),
            onChanged: (value) {
              _textRed = value.toInt();
              _textColor =
                  Color.fromRGBO(_textRed, _textGreen, _textBlue, _opacity);
              fontController.updateTextColor(_textColor);
              setState(() {});
              widget.textColorChanged(_textColor);
            },
          ),
          LockableSlider(
            lockchanged: (val) {
              _greenTextIsUnlocked = val;
            },
            colorName: "Green",
            value: _textGreen.toDouble(),
            onChanged: (value) {
              _textGreen = value.toInt();
              _textColor =
                  Color.fromRGBO(_textRed, _textGreen, _textBlue, _opacity);
              fontController.updateTextColor(_textColor);
              setState(() {});
              widget.textColorChanged(_textColor);
            },
          ),
          LockableSlider(
            lockchanged: (val) {
              _blueTextIsUnlocked = val;
            },
            colorName: "Blue",
            value: _textBlue.toDouble(),
            onChanged: (value) {
              _textBlue = value.toInt();

              _textColor =
                  Color.fromRGBO(_textRed, _textGreen, _textBlue, _opacity);
              fontController.updateTextColor(_textColor);

              setState(() {});
              widget.textColorChanged(_textColor);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width * 0.4),
              IconButton(
                  padding: EdgeInsets.all(1),
                  icon: Image.asset('assets/circle.png'),
                  onPressed: () {
                    Color textColor = colorController.randomizeRGBOColor(
                        red: !_redTextIsUnlocked ? _textRed : null,
                        green: !_greenTextIsUnlocked ? _textGreen : null,
                        blue: !_blueTextIsUnlocked ? _textBlue : null);
                    _textRed = textColor.red;
                    _textGreen = textColor.green;
                    _textBlue = textColor.blue;
                    _textColor = textColor;

                    fontController.updateTextColor(_textColor);

                    setState(() {});
                    widget.textColorChanged(_textColor);
                  }),
              SizedBox(width: MediaQuery.of(context).size.width * 0.27),
            ],
          ),
        ]),
      ),
    );
  }
}
