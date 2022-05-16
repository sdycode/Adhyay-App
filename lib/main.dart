
import 'package:ads_code_library_issue/providers/provider.dart';
import 'package:ads_code_library_issue/providers/sharedPref.dart';
import 'package:ads_code_library_issue/screens.dart/screen1.dart';
import 'package:ads_code_library_issue/screens.dart/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:change_app_package_name/change_app_package_name.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();

 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
          builder: (x, w) {
            Products products = Provider.of<Products>(x);
            print("in main");
            products.incrementLaunchCount();
            return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: products.getLaunchCount() > 2
                    ? Screen1(products)
                    : SplashScreen(products, true));
          },
        ),
      ],
    );
  }
 

}
