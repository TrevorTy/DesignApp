import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as prefix0;
import 'package:design_by_me/_services/firestore_service.dart';
import 'package:design_by_me/models/font_config.dart';
import 'package:design_by_me/models/font_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:design_by_me/_utils/color_generator.dart';

class UserController {
  FirebaseUser _user;
  //HomeBody homeBody;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService service = FirestoreService();

  saveFontData(FontData fontData, Color fontColor, Color backgroundColor,
      String quote) async {
    var fontJson = Map<String, dynamic>(); // Map
    //you can alos make a utilities class with static
    var _backGroundColorHex =
        ColorGenerator.convertRBGtoHexString(backgroundColor);
    var _fontColorHex = ColorGenerator.convertRBGtoHexString(fontColor);

    fontJson['fontData'] = fontData.toJson();

    fontJson['quote'] = quote;
    fontJson['fontColor'] = _fontColorHex;
    fontJson['backGroundColor'] = _backGroundColorHex;
    fontJson['userId'] = _user.uid;
    // DateTime _now = DateTime.now();
    // String formattedDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    // fontJson['date'] = formattedDate;
    prefix0.Timestamp date = Timestamp.now();
    fontJson['date'] = date;

    Firestore.instance.collection('savedFonts').document().setData(fontJson);
  }

  Stream<List<FontConfig>> getStream() {
    var stream = service.getFontConfigStream(_user.uid);
    return stream;
  }

  Stream<List<FontConfig>> getLastSavedFontSream() {
    var stream = service.getLastSavedFont(_user.uid);
    return stream;
  }

  Future deleteData(FontConfig fontConfig) async {
    var myDoc = await Firestore.instance
        .collection('savedFonts')
        .document(fontConfig.id)
        .delete()
        .catchError((e) {
      print(e);
    });
    return myDoc;
  }

  Future handleSignIn() async {
    //show a loader
    // await auth.signOut();
    // return;
    _user = await auth.currentUser();
    if (_user == null) {
      _user = (await auth.signInAnonymously()).user;
      // print("signed in " + user.uid);
      return _user;
    }
  }

  //TODO THIS FILE IN A UTILS CLASS
  //Move this method to font or backgroundcontroller
  Color hexToColor(String hexColor) {
    return new Color(
        int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
  }

  void signOut() async {
    await auth.signOut();
  }
}
