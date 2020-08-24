import 'package:design_by_me/models/font_file_model.dart';
import 'package:design_by_me/views/bottom_bars/color_bottom_bar_view.dart';
import 'package:design_by_me/views//bottom_bars/font_bottom_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:design_by_me/controllers/font_controller.dart';
import 'package:provider/provider.dart';

class BottomBarUI extends StatefulWidget {
  const BottomBarUI({
    Key key,
    this.onFontPressed,
    this.onSavePressed,
    this.backgroundColor = Colors.black,
    this.textColor,
    this.onColorPressed,
  }) : super(key: key);
  final Function onFontPressed;
  final Function onSavePressed;
  final Function onColorPressed;
  final Color backgroundColor;
  final Color textColor;

  @override
  _BottomBarUIState createState() => _BottomBarUIState();
}

class _BottomBarUIState extends State<BottomBarUI> {
  showBottomMenu(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return FontBottomBarView(
            backgroundColor: widget.backgroundColor,
            textColor: widget.textColor,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: bottomNavigationBar(context),
    );
  }

  bottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: widget.backgroundColor,
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // IconButton(
            //   icon: Image.asset('assets/square.png', color: textColor,),
            //   onPressed: () {},
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 64.0),
              child: CustomIconButton(
                onLongPressed: () => showBottomMenu(context),
                onDoubleTap: () => showBottomMenu(context),
                icon: Image.asset(
                  'assets/text.png',
                  color: widget.textColor,
                ),
                onPressed: widget.onFontPressed,
              ),
            ),
            CustomIconButton(
              icon: Image.asset(
                'assets/circle.png',
                color: widget.textColor,
              ),
              onPressed: widget.onColorPressed,
              onDoubleTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return BottomPanel(
                      backgroundColor: widget.backgroundColor,
                      textColor: widget.textColor,
                    );
                  }),
              // onLongPressed: showColorMenu(context),
              onLongPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return BottomPanel(
                      backgroundColor: widget.backgroundColor,
                      textColor: widget.textColor,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 64.0),
              child: CustomIconButton(
                icon: Image.asset(
                  'assets/add.png',
                  color: widget.textColor,
                ),
                onPressed: widget.onSavePressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//MAke a stream with rxDart
class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key key,
      this.icon,
      this.onLongPressed,
      this.onPressed,
      this.onDoubleTap})
      : super(key: key);
  final Image icon;
  final Function onLongPressed;
  final Function onPressed;
  final Function onDoubleTap;
//'assets/circle.png'
  //  'assets/add.png',
// 'assets/text.png',
//onFontPressed
//onSavePressed
  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      width: 40.0,
      height: 40.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        child: icon,
        onTap: onPressed,
        onLongPress: onLongPressed,
        onDoubleTap: onDoubleTap,
      ),
    );
  }
}

class TextSlider extends StatefulWidget {
  TextSlider(
      {Key key,
      this.initialValue = 5.0,
      @required this.onValueChanged,
      this.interfaceColor})
      : super(key: key);
  final double initialValue;
  final Function(double) onValueChanged;
  final Color interfaceColor;
  @override
  _TextSliderState createState() => _TextSliderState();
}

class _TextSliderState extends State<TextSlider> {
  double currentValue;
  //Color interfaceColor;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: Slider.adaptive(
        //activeColor: widget.interfaceColor,
        //inactiveColor: widget.interfaceColor,
        inactiveColor: Colors.white,
        activeColor: Colors.white,
        divisions: 30,
        value: currentValue,
        min: 1,
        max: 30,
        onChanged: (double newValue) {
          setState(() {
            currentValue = newValue;
          });
          widget.onValueChanged(newValue);
        },
      ),
    );
  }
}

class DropDownButtonFont extends StatefulWidget {
  final Color dropDonwTextColor;
  //Dont forget to add 'widget.' before you use this constructor
  DropDownButtonFont({this.dropDonwTextColor});
  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButtonFont> {
  FontWeightData dropdownValue;
  //Color dropdownColor;

  setDropdownValue(List<FontWeightData> data) {
    if (dropdownValue == null) {
      dropdownValue = data.firstWhere((item) => item.name == 'regular');
    }
  }

  loadNewFont(FontController fontController, FontWeightData data) async {
    //ByteData byteData = await fontController.fetchFont(data.url);
    await fontController.loadFont(
        fontController.currentFontData.family, data.url);
    fontController.updateFontData(data);

    //fontController.u
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FontController fontController = Provider.of<FontController>(context);
    setDropdownValue(fontController.currentFontData.fontFileData.fontWeights);
    return Theme(
      data: ThemeData(canvasColor: Colors.black),
      child: DropdownButton<FontWeightData>(
        isDense: true,
        hint: Text(
          'Select Font',
          textAlign: TextAlign.start,
        ),
        value: dropdownValue,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: widget.dropDonwTextColor,
        ),
        iconSize: 30,
        //elevation: 50,
        style: TextStyle(color: Colors.white, fontSize: 14.0),
        underline: Container(
            //height: 2,
            // color: widget.dropDonwTextColor,
            ),
        onChanged: (FontWeightData newValue) {
          setState(() {
            //Call the loadfontfunction from Home
            loadNewFont(fontController, newValue);
            dropdownValue = newValue;
          });
        },
        items: fontController.currentFontData.fontFileData.fontWeights
            .map<DropdownMenuItem<FontWeightData>>((FontWeightData value) {
          return DropdownMenuItem<FontWeightData>(
            value: value,
            child: Text(
              value.name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
