import 'package:design_by_me/_utils/color_generator.dart';
import 'package:design_by_me/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/user_authentication.dart';
import 'controllers/font_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Provider<FontController> fontProvider =
      Provider<FontController>.value(value: FontController());
  final Provider<ColorGenerator> colorGenerator =
      Provider<ColorGenerator>.value(value: ColorGenerator());
  final Provider<UserController> userController =
      Provider<UserController>.value(value: UserController());
  final Provider<UserAuthentication> userAuth =
      Provider<UserAuthentication>.value(value: UserAuthentication());
//final GoogleSignIn _googleSignIn = GoogleSignIn();
//final FirebaseAuth auth = FirebaseAuth.instance.;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [fontProvider, userController, colorGenerator, userAuth],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        title: 'Designbyme',
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
          body: UserAuthentication(),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
