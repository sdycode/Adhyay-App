
import 'package:ads_code_library_issue/constants.dart';
import 'package:ads_code_library_issue/providers/provider.dart';
import 'package:ads_code_library_issue/providers/sharedPref.dart';
import 'package:ads_code_library_issue/screens.dart/admin_screen.dart';
import 'package:ads_code_library_issue/screens.dart/screen1.dart';
import 'package:ads_code_library_issue/screens.dart/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int currentTapIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if ((SharedPref.pref.getInt('index') ?? 0)  < 2) {
      currentTapIndex = SharedPref.pref.getInt('index') ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Products p = Provider.of<Products>(context);
    return Drawer(
      child: Column(
        children: [
        SizedBox(height: 80,),
             ListTile(
            leading: const Icon(Icons.face ),
            title: currentTapIndex == 0
                ? Text("${Constants.names[p.getPurushIndexFun()]}")
                : Text("${Constants.mahilasNames[p.getMahilaIndexFun()]}"),
            onTap: () {
              Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SplashScreen(p, false)));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.iso),
            title: const Text("Message"),
            onTap: () {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => Screen1(p)));
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online),
            title: const Text("Admin "),
            onTap: () {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => AdminScreen()));
              });
            },
          ),
        ],
      ),
    );
  }
}
