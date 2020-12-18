import 'package:flutter/material.dart';
import 'package:spending_analytics/data/repository/ApiReposytory.dart';
import 'package:spending_analytics/data/repository/SharPrefRepositiry.dart';
import 'package:spending_analytics/ui/AuthPage/AuthScreen.dart';
import 'package:spending_analytics/ui/MainPage/MainPage.dart';
import 'package:spending_analytics/ui/PinPage/PinPage.dart';

import 'ui/AuthPage/PinCodePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool alreadyLogin = false;
  String token = await SharedPrefRepository().getUserToken();

  if(token != null) {
    alreadyLogin = true;
    ApiRepository.setToken = token;
  }

  runApp(SpendingAnalytics(alreadyLogin));

}

class SpendingAnalytics extends StatelessWidget {
  SpendingAnalytics(this.alreadyLogin);

  final bool alreadyLogin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white
      ),

      initialRoute: alreadyLogin ? pinPageRoute : authPageRoute,
      routes: {
        authPageRoute: (context) => LoginPage(),
        pinPageRoute: (context) => PinCodePage(PinState.checkPin),
        mainPageRoute: (context) => MainPage(SharedPrefRepository()),
      },
    );
  }
}

const String authPageRoute = '/authRoute';
const String mainPageRoute = '/mainRoute';
const String pinPageRoute = '/pinRoute';
