import 'dart:async';
import 'package:design_by_me/views/components/adjustable_fontsize.dart';
import 'package:design_by_me/controllers/font_controller.dart';
import 'package:design_by_me/_utils/random_text_generator.dart';
import 'package:design_by_me/controllers/user_controller.dart';
import 'package:design_by_me/models/font_config.dart';
import 'package:design_by_me/models/font_data_model.dart';
import 'package:design_by_me/views/user_authentication.dart';
import 'package:design_by_me/views/bottom_bars/bottom_bar_view.dart';
import 'package:design_by_me/views/saved_fonts_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_by_me/_utils/color_generator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FontController controller;
  FontData currentFontData;
  bool _isLoading = false;
  Color _backgroundColor;
  Color _textColor;
  bool _justsavedFont;
  String _quote;
  StreamSubscription<UISettings> _subscription;
  bool _lockFontLoading = false;
  bool _justSavedColor = false;
  //var randomFont = controller.getRandomFontData();

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  //This is a broadcast https://pub.dev/documentation/rxdart/latest/rx/BehaviorSubject-class.html
  listenToUISettings() {
    if (_subscription == null) {
      _subscription = controller.fontSettingStream.listen((setting) {
        setState(() {
          _backgroundColor = setting.backgroundColor;
          _textColor = setting.textColor;
          _justSavedColor = false;
        });
      });
    }
  }

  Future loadFont(FontController controller) async {
    ColorGenerator colorGenerator = Provider.of<ColorGenerator>(context);
    if (_isLoading) return;
    _isLoading = true;
    var randomFont = controller.getRandomFontData();
    await controller.loadFont(
        randomFont.family, randomFont.fontFileData.regular);
    //always use setState to see the changes in the UI or
    //In a statelesswidget you have to use a streambuilder
    _isLoading = false;
    setState(() {
      _justsavedFont = false;
      _quote = RandomTextGenerator.randomizeQuote();
      currentFontData = randomFont;
      _backgroundColor = colorGenerator.randomizeRGBOColor();

      _textColor = colorGenerator.randomizeRGBOColor();
    });
    FontController fontController = Provider.of<FontController>(context);
    fontController.updateBackgroundColor(_backgroundColor);
    fontController.updateTextColor(_textColor);
  }

  void saveFont() {
    if (!_justsavedFont || !_justSavedColor) {
      UserController userController = Provider.of<UserController>(context);
      userController.saveFontData(
        currentFontData,
        _textColor,
        _backgroundColor,
        currentFontData.family.toString().substring(0, 1),
      );
      _justsavedFont = true;
      _justSavedColor = true;
      toastMessage();
    }
    return;
  }

  toastMessage() {
    Scaffold.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 2,
        //  shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(20)),
        duration: Duration(milliseconds: 1500),
        backgroundColor: _textColor,
        content: Text(
          RandomToastText.randomizeToastText(),
          textAlign: TextAlign.center,
          style: TextStyle(color: _backgroundColor, fontSize: 20),
        )));
  }

  @override
  Widget build(BuildContext context) {
    controller = Provider.of<FontController>(context);
    ColorGenerator colorGenerator = Provider.of<ColorGenerator>(context);
    UserAuthentication auth = Provider.of<UserAuthentication>(context);
    //loadFont(controller);

    listenToUISettings();
    return Scaffold(
      backgroundColor: _backgroundColor,
      bottomNavigationBar: BottomBarUI(
          backgroundColor: _backgroundColor,
          textColor: _textColor,

          //Also change
          onFontPressed: () async {
            if (!_lockFontLoading) {
              _lockFontLoading = true;
              loadFont(controller);
              await Future.delayed(
                Duration(milliseconds: 1500),
              );
              _lockFontLoading = false;
            }
          },
          onColorPressed: () {
            setState(() {
              _backgroundColor = colorGenerator.randomizeRGBOColor();
              _textColor = colorGenerator.randomizeRGBOColor();
              _justSavedColor = false;
            });
          },
          onSavePressed: () => saveFont()),
      body: FutureBuilder(
        future: controller.loadAllFonts(),
        initialData: null,
        builder:
            (BuildContext context, AsyncSnapshot<List<FontData>> snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
            // return Image.asset('assets/defigners_logo.jpg');
          }
          if (snapshot.data != null && currentFontData == null) {
            loadFont(controller);
            return Center(child: CircularProgressIndicator());
          }
          //also use setstate // so adjust textstyle
          var textStyle = TextStyle();

          if (currentFontData != null) {
            textStyle = TextStyle(
                fontFamily: currentFontData.family,
                fontSize: 30.0,
                color: _textColor);
          }

          return SafeArea(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: HomeBody(
                    quote: _quote,
                    textStyle: textStyle,
                    currentFontData: currentFontData,
                    colorGenerator: colorGenerator,
                    backgroundColor: _backgroundColor,
                    textColor: _textColor,
                    userAuthentication: auth,
                    // fontConfig: ,
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: GestureDetector(
                    child: IconButton(
                      color: Colors.red,
                      icon: Image.asset(
                        'assets/arrow.png',
                        color: _textColor,
                      ),
                      onPressed: () async {
                        FontConfig fontConfig = FontConfig();
                        Color fromHex(String hexString) {
                          final buffer = StringBuffer();
                          if (hexString.length == 6 || hexString.length == 7)
                            buffer.write('ff');
                          buffer.write(hexString.replaceFirst('#', ''));
                          return Color(int.parse(buffer.toString(), radix: 16));
                        }

                        var result = await Navigator.push(
                            context, SlideRightRoute(page: SavedFontsScreen()));
                        if (result == null) return;
                        setState(() {
                          fontConfig = result;
                          currentFontData = fontConfig.fontData;
                          Color newBackgroundColor =
                              fromHex(fontConfig.backGroundColor);
                          Color newTextColor = fromHex(fontConfig.fontColor);
                          //UserController userController = UserController();
                          _backgroundColor = newBackgroundColor;
                          _textColor = newTextColor;
                          // userController
                          //     .hexToColor(newBackgroundColor);
                          // _textColor =
                          //     userController.hexToColor(fontConfig.fontColor);
                          // print(newBackgroundColor);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key key,
    @required this.userAuthentication,
    @required this.quote,
    @required this.textStyle,
    @required this.currentFontData,
    @required this.colorGenerator,
    @required this.backgroundColor,
    @required this.textColor,
  }) : super(key: key);

  final UserAuthentication userAuthentication;
  final String quote; //Send the quote and not the controller
  final TextStyle textStyle;
  final FontData currentFontData;
  final ColorGenerator colorGenerator;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    var fontController = Provider.of<FontController>(context);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        //padding
        children: <Widget>[
          Flexible(
            flex: 3,
            child: FittedBox(
              child: AdjustableFontSizeText(
                currentFontData.family.toString().substring(0, 1),
                fontHeight: 1.0,
                fontSize: 200,
                initialValue: fontController.currentFontSetting,
                fontColor: textColor,
                fontFamily: currentFontData.family,
                stream: fontController.fontSettingStream,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: AdjustableFontSizeText(
                    quote,
                    initialValue: fontController.currentFontSetting,
                    fontColor: textColor,
                    fontFamily: currentFontData.family,
                    stream: fontController.fontSettingStream,
                  ),
                ),
              ],
            ),
          ),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  currentFontData.family,
                  textAlign: TextAlign.start,
                  textWidthBasis: TextWidthBasis.longestLine,
                  style: TextStyle(
                      fontSize: 30,
                      color: textColor,
                      fontFamily: currentFontData.family),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Font Color',
                          style: TextStyle(
                            color: textColor,
                            fontFamily: currentFontData.family,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '${ColorGenerator.convertRBGtoHexString(textColor)}',
                          style: TextStyle(
                            color: textColor,
                            fontFamily: currentFontData.family,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Background',
                          style: TextStyle(
                              color: textColor,
                              fontFamily: currentFontData.family,
                              fontSize: 20),
                        ),
                        Text(
                          '${ColorGenerator.convertRBGtoHexString(backgroundColor)}',
                          style: TextStyle(
                              color: textColor,
                              fontFamily: currentFontData.family,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
