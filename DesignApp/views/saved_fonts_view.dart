import 'package:design_by_me/controllers/user_controller.dart';
import 'package:design_by_me/models/font_config.dart';
import 'package:design_by_me/views/home_view.dart';
import 'package:design_by_me/views/settings_menu_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SavedFontsScreen extends StatefulWidget {
  @override
  _SavedFontsScreenState createState() => _SavedFontsScreenState();
}

class _SavedFontsScreenState extends State<SavedFontsScreen> {
  // final CollectionReference collectionReference =
  //     Firestore.instance.collection("savedFonts");

  //UserController userController;

  @override
  Widget build(BuildContext context) {
    UserController userController = Provider.of<UserController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () async {
            await Navigator.push(
                context, SlideRightRoute(page: SettingsMenuScreen()));
          },
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Saved Fonts",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/arrow.png',
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: StreamBuilder<List<FontConfig>>(
        stream: userController.getStream(),
        initialData: null, //Your widget should show a placeholder here
        builder:
            (BuildContext context, AsyncSnapshot<List<FontConfig>> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            //return CircularProgressIndicator();
          }

          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          return userController.getStream() != null
              ? StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  crossAxisCount: 4,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GridViewItem(fontConfig: snapshot.data[index]);
                    //FontConfig fontConfig = snapshot.data[index];

                    //Make a method and do it inside the fonts class
                    // Timestamp timeStamp = fontConfig.date;
                    // var newdate = timeStamp.toDate();
                    // String fontTime =
                    //     formatDate(newdate, [yyyy, '-', mm, '-', dd]);
                  },
                  //Gridview
                  staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                  mainAxisSpacing: 0.5,
                  crossAxisSpacing: 0.5)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class GridViewItem extends StatefulWidget {
  final FontConfig fontConfig;

  GridViewItem({this.fontConfig});
  @override
  _GridViewItemState createState() => _GridViewItemState();
}

class _GridViewItemState extends State<GridViewItem> {
  Positioned buildPositioned(BuildContext context, FontConfig fontConfig,
      UserController userController) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        //  color: Colors.white,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: Colors.white),
        height: 100,
        //color: Colors.white,
        child: Row(
          children: <Widget>[
            //Custom button or materialbutton
            //A widget with a gesturedectector
            Expanded(
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/ic_edit.png'),
                    onPressed: () {
                      Navigator.pop(context, fontConfig);
                    },
                  ),
                  Text('Edit'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  IconButton(
                    onPressed: () =>
                        userController.deleteData(widget.fontConfig),
                    icon: Image.asset('assets/ic_close.png'),
                  ),
                  Text('Delete')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    UserController userController = Provider.of<UserController>(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (showMenu == false)
            showMenu = true;
          else {
            showMenu = false;
          }
        });
      },
      child: FittedBox(
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 5,
              child: Material(
                shadowColor: userController
                    .hexToColor(widget.fontConfig.backGroundColor),
                color: userController
                    .hexToColor(widget.fontConfig.backGroundColor),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${widget.fontConfig.quote}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: userController
                                  .hexToColor(widget.fontConfig.fontColor),
                              fontFamily: widget.fontConfig.fontData.family,
                              fontSize: 100.0),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, bottom: 16.0, right: 16.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${widget.fontConfig.fontData.family}',
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Background  ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins-ExtraLight',
                                      fontSize: 12.0),
                                ),
                                Text(
                                  widget.fontConfig.backGroundColor,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Text  ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins-ExtraLight',
                                      fontSize: 12.0),
                                ),
                                Text(
                                  widget.fontConfig.fontColor,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            //Text(fontTime),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            showMenu
                ? buildPositioned(context, widget.fontConfig, userController)
                : Text('')
          ],
        ),
      ),
    );
  }
}
