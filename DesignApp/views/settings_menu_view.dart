import 'package:design_by_me/controllers/user_controller.dart';
import 'package:design_by_me/models/font_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class SettingsMenuScreen extends StatelessWidget {
  _launchURL1() async {
    const url = 'https://www.defigners.nl/work/designbyme/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL() async {
    const url =
        'https://firebasestorage.googleapis.com/v0/b/designbyme-9b8a1.appspot.com/o/dbm_privacy_policy.pdf?alt=media';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL3() async {
    const url = 'https://forms.gle/atsRFJ32ezuVYohS7';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = "v${packageInfo.version}";
    return version;
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = Provider.of<UserController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Last Chosen Design",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        //leading: null,
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/arrow.png'),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 375.33 / 360.0,
            child: StreamBuilder<List<FontConfig>>(
                stream: userController.getLastSavedFontSream(),
                initialData: null,
                builder: (context, AsyncSnapshot<List<FontConfig>> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    //return CircularProgressIndicator();
                  }
                  if (snapshot.data == null) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.data.length == 0) {
                    return Text("D");
                  }
                  FontConfig snapshotData = snapshot.data[0];
                  return Container(
                    color:
                        userController.hexToColor(snapshotData.backGroundColor),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${snapshotData.fontData.family.toString().substring(0, 1)}',
                            style: TextStyle(
                              fontSize: 190,
                              color: userController
                                  .hexToColor(snapshotData.fontColor),
                            ),
                          ),
                          Text(
                            snapshotData.fontData.family.toString(),
                            style: TextStyle(
                              color: userController
                                  .hexToColor(snapshotData.fontColor),
                              fontSize: 20.0,
                            ),
                          ),
                          Column(
                            children: <Widget>[],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          FlatButton(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "Privacy Policy",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              _launchURL();
            },
          ),
          FlatButton(
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Feedback",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            onPressed: () {
              _launchURL3();
            },
          ),
          FlatButton(
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  "About",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            onPressed: () async {
              //await Navigator.push(context, SlideRightRoute(page: AboutPage()));
              _launchURL1();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: ListTile(
              enabled: false,
              title: Text(""),
              trailing: FutureBuilder(
                future: getVersionNumber(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) =>
                        Text(
                  snapshot.hasData ? snapshot.data : "Loading",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
