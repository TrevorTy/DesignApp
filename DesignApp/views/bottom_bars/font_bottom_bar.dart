import 'package:design_by_me/controllers/font_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_by_me/views/bottom_bars/bottom_bar_view.dart';

class FontBottomBarView extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;

  const FontBottomBarView(
      {Key key, @required this.backgroundColor, @required this.textColor})
      : super(key: key);

  @override
  _FontBottomBarViewState createState() => _FontBottomBarViewState();
}

class _FontBottomBarViewState extends State<FontBottomBarView> {
  @override
  Widget build(BuildContext context) {
    FontController fontController = Provider.of<FontController>(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: widget.backgroundColor),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      fontController.currentFontData.family,
                      style: TextStyle(color: widget.textColor, fontSize: 20.0),
                    ),
                    DropDownButtonFont(
                      dropDonwTextColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width - 32,
              child: Divider(
                color: Colors.white,
                height: 2.0,
                thickness: 2.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Total Size ${fontController.currentFontSetting.fontSize} px',
                  style: TextStyle(color: Colors.white),
                ),
                TextSlider(
                    interfaceColor: Colors.white,
                    initialValue: fontController.currentFontSetting.fontSize,
                    onValueChanged: (val) {
                      fontController.updateFontSize(val);

                      setState(() {});
                    }),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Line height ${fontController.currentFontSetting.lineHeight} px',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextSlider(
                    // interfaceColor: textColor,
                    initialValue: fontController.currentFontSetting.lineHeight,
                    onValueChanged: (val) {
                      fontController.updateLineHeight(val);
                      setState(() {});
                    }),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
