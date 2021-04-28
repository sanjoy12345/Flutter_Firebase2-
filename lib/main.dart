import 'package:flutter/material.dart';
import 'package:iu_bus_schedule/states/app_state.dart';
import 'package:provider/provider.dart';
import './ui/home.dart';



//void main() {
//  return runApp(MultiProvider(providers: [
//    ChangeNotifierProvider.value(value: AppState(),)
//  ],
//    child: MyApp(),));
//}
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: AppState(),
      )
    ],
    child: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iu_bus_schedule',
      theme:  ThemeData(primarySwatch: Colors.red,accentColor: Colors.redAccent),
      home: SplashScreen(),

    );
  }
}
