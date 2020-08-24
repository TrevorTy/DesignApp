import 'package:design_by_me/views/components/lockable_slider.dart';
import 'package:design_by_me/_utils/color_generator.dart';
import 'package:design_by_me/controllers/font_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackgroundColorBottomBarView extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final Function changeView;
  final Function(Color) bgColorChanged;
  BackgroundColorBottomBarView(
      {Key key,
      @required this.backgroundColor,
      this.textColor,
      this.bgColorChanged,
      this.changeView})
      : super(key: key);

  @override
  _BackgroundColorBottomBarViewState createState() =>
      _BackgroundColorBottomBarViewState();
}

class _BackgroundColorBottomBarViewState
    extends State<BackgroundColorBottomBarView> {
  bool _redIsUnlocked = true;
  bool _greenIsUnlocked = true;
  bool _blueIsUnlocked = true;

  int _bgRed;
  int _bgGreen;
  int _bgBlue;
  Color _backgroundColor;
  //Color _textColor;
  double opacity = 1;
  bool maximizedWindow = true;

  @override
  void initState() {
    // _textColor = widget.textColor;
    _backgroundColor = widget.backgroundColor;
    _bgRed = widget.backgroundColor.red;
    _bgGreen = widget.backgroundColor.green;
    _bgBlue = widget.backgroundColor.blue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FontController fontController = Provider.of<FontController>(context);
    ColorGenerator colorGenerator = Provider.of<ColorGenerator>(context);
    //bool _maximizedWindow = true;
    bool maxwindow = true;

    return maxwindow
        ? Container(
            //make a widget of the container
            // color: backgroundColor,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(30), color: backgroundColor),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: _backgroundColor),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  LockableSlider(
                    lockchanged: (val) {
                      _redIsUnlocked = val;
                    },
                    colorName: "Red",
                    value: _bgRed.toDouble(),
                    onChanged: (value) {
                      _bgRed = value.toInt();
                      _backgroundColor =
                          Color.fromRGBO(_bgRed, _bgGreen, _bgBlue, opacity);
                      fontController.updateBackgroundColor(_backgroundColor);
                      setState(() {});
                      widget.bgColorChanged(_backgroundColor);
                    },
                  ),
                  LockableSlider(
                    lockchanged: (val) {
                      _greenIsUnlocked = val;
                    },
                    colorName: "Green",
                    value: _bgGreen.toDouble(),
                    onChanged: (value) {
                      _bgGreen = value.toInt();
                      _backgroundColor =
                          Color.fromRGBO(_bgRed, _bgGreen, _bgBlue, opacity);
                      fontController.updateBackgroundColor(_backgroundColor);
                      setState(() {});
                      widget.bgColorChanged(_backgroundColor);
                    },
                  ),
                  LockableSlider(
                    lockchanged: (val) {
                      _blueIsUnlocked = val;
                    },
                    colorName: "Blue",
                    value: _bgBlue.toDouble(),
                    onChanged: (value) {
                      _bgBlue = value.toInt();
                      _backgroundColor =
                          Color.fromRGBO(_bgRed, _bgGreen, _bgBlue, opacity);
                      fontController.updateBackgroundColor(_backgroundColor);
                      setState(() {});
                      widget.bgColorChanged(_backgroundColor);
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Text(
                  //       'Text ${BackgroundController.convertRBGtoHexString(_textColor)}',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     // SizedBox(width: MediaQuery.of(context).size.width * 0),
                  IconButton(
                      padding: EdgeInsets.all(1),
                      icon: Image.asset('assets/circle.png'),
                      onPressed: () {
                        //  randomizeBgColor();
                        Color bgColor = colorGenerator.randomizeRGBOColor(
                            red: !_redIsUnlocked ? _bgRed : null,
                            green: !_greenIsUnlocked ? _bgGreen : null,
                            blue: !_blueIsUnlocked ? _bgBlue : null);
                        _bgRed = bgColor.red;
                        _bgGreen = bgColor.green;
                        _bgBlue = bgColor.blue;
                        _backgroundColor = bgColor;

                        fontController.updateBackgroundColor(_backgroundColor);
                        setState(() {});
                        widget.bgColorChanged(_backgroundColor);
                      }),
                  //     IconButton(
                  //         // alignment: ,
                  //         icon: Icon(
                  //           Icons.keyboard_arrow_down,
                  //           color: Colors.white,
                  //         ),
                  //         onPressed: () {
                  //           widget.changeView();
                  //         }),
                  //   ],
                  // ),
                ],
              ),
            ),
          )
        : Container();
  }
}
