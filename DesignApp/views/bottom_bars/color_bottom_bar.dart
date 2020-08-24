import 'package:design_by_me/_utils/color_generator.dart';
import 'package:design_by_me/views/bottom_bars/background_color_bottom_bar_view.dart';
import 'package:design_by_me/views/bottom_bars/text_color_bottom_bar_view.dart';
import 'package:flutter/material.dart';

class BottomPanel extends StatefulWidget {
  BottomPanel({Key key, this.backgroundColor, this.textColor})
      : super(key: key);

  final Color backgroundColor;
  final Color textColor;
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  int _index = 0;
  Color _backgroundColor;
  Color _textColor;
  @override
  void initState() {
    _backgroundColor = widget.backgroundColor;
    _textColor = widget.textColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // decoration: BoxDecoration(),
        color: _backgroundColor,
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return Theme(
      data: Theme.of(context).copyWith(cardColor: _backgroundColor),
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _index = index;
          });
        },
        children: [
          ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Container(
                  decoration: BoxDecoration(
                      color: _backgroundColor,
                      // borderRadius: BorderRadius.circular(30), color: backgroundColor),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  //color:_backgroundColor,
                  child: ListTile(
                    dense: true,
                    // contentPadding: const EdgeInsets.all(0),
                    title: Row(
                      children: <Widget>[
                        Text(
                          "Background",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 20),
                        Text(
                          //  "#${_backgroundColor.toString().substring(9)}",
                          "${ColorGenerator.convertRBGtoHexString(_backgroundColor)}",

                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
              isExpanded: _index == 0,
              body: BackgroundColorBottomBarView(
                  backgroundColor: _backgroundColor,
                  textColor: widget.textColor,
                  bgColorChanged: (value) {
                    setState(() {
                      _backgroundColor = value;
                    });
                  })),
          ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Container(
                  color: _backgroundColor,
                  child: ListTile(
                    dense: true,
                    title: Row(
                      children: <Widget>[
                        Text(
                          "Text",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "${ColorGenerator.convertRBGtoHexString(_textColor)}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
              isExpanded: _index == 1,
              body: TextColorBottomBarView(
                backgroundColor: _backgroundColor,
                textColor: _textColor,
                textColorChanged: (value) {
                  setState(() {
                    _textColor = value;
                  });
                },
              )),
        ],
      ),
    );
  }
}
