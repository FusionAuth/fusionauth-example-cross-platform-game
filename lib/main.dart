import 'package:flutter/material.dart';
import 'package:fusionauth_game/game_screen.dart';
import 'package:fusionauth_game/login_screen.dart';
import 'package:fusionauth_game/network.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool userStatus = await checkUserIsLoggedIn();
  runApp(MyApp(
    status: false,
  ));
}

class MyApp extends StatelessWidget {
  final bool status;
  MyApp({Key? key, this.status = false}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: status ? GameScreen() : LoginScreen(),
    );
  }
}

Future<bool> checkUserIsLoggedIn() async {
  if (await secureStorage.containsKey(key: 'tokenExpirationInstant')) {
    print(DateTime.now().millisecondsSinceEpoch);
    var expiry = await secureStorage.read(key: 'tokenExpirationInstant');
    if (DateTime.now().millisecondsSinceEpoch < int.parse(expiry!)) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
