import 'package:ads_code_library_issue/providers/provider.dart';
import 'package:ads_code_library_issue/providers/sharedPref.dart';
import 'package:ads_code_library_issue/screens.dart/screen1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ads_code_library_issue/providers/provider.dart';
import 'package:ads_code_library_issue/providers/sharedPref.dart';
import 'package:ads_code_library_issue/widgets/app_drawer.dart';
import 'package:clipboard/clipboard.dart';

import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SplashScreen extends StatefulWidget {
  Products products;
  bool fromMain;
  SplashScreen(
    this.products,
    this.fromMain,
  );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Products? products;
  bool? fromMain;
  int currentTapIndex = 2;
  int purushIndex = 0;
  int mahilaIndex = 0;

  @override
  void initState() {
    initialiseSharedPref();
    mahilaIndex = SharedPref.pref.getInt('mahilaIndex') ?? 0;
    purushIndex = SharedPref.pref.getInt('purushIndex') ?? 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    products = Provider.of<Products>(context);

    // print("name index ${products!.getPurushIndexFun()}");
    // print("purush index ${purushIndex}");
    // print("mahi name index ${products!.getMahilaIndexFun()}");
    // print("mahils index ${mahilaIndex}");
    purushIndex = products!.getPurushIndexFun();
    mahilaIndex = products!.getMahilaIndexFun();

    // currentTapIndex = products!.whichPathIndex;

    Constants.sh = sh;
    Constants.sw = sw;
    return Scaffold(
        body: SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bottomIconImage(0, sw, sh),
            bottomIconImage(1, sw, sh),
          ],
        ),
        // purushNamesChips(),
        currentTapIndex != 2
            ? (currentTapIndex == 0 ? purushNamesChips() : mahilaNamesChips())
            : Container(height: sh * 0.1, margin: EdgeInsets.all(10)),
        goButton(),
      ]),
    ));
  }

  Widget bottomIconImage(int i, double sw, double sh) {
    return InkWell(
      onTap: () {
        setState(() {
          currentTapIndex = i;
        });
      },
      child: Container(
        width: sw * 0.4,
        height: sh * 0.12+10+8,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: currentTapIndex == i ? Constants.grey : Constants.lightgrey,
            border: Border.all(
              color: currentTapIndex == i ? Colors.black : Colors.white70,
              width: 3,
            )),
        child: Container(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(4),
              height: sh * 0.12 ,
              child: Image.asset(Constants.iconImgNames[i]),
            )
          ],
        )),
      ),
    );
  }

  Future checkFirstSeen() async {
    bool _seen = (SharedPref.pref.getBool('seen') ?? false);
    // bool _seen = false;
    if (_seen) {
      Navigator.push(context, MaterialPageRoute(builder: (c) {
        return Screen1(widget.products);
      }));
    } else {
      await SharedPref.pref.setBool('seen', true);
      Navigator.push(context, MaterialPageRoute(builder: (c) {
        return Screen1(widget.products);
      }));
    }
  }

  void initialiseSharedPref() {
    print("from main ${widget.fromMain}");
    print("launch count  ${widget.products.getLaunchCount()}");
    if (widget.fromMain && widget.products.getLaunchCount() > 2) {
      print("cc ${currentTapIndex}");
      products!.setPathIndex(currentTapIndex);
      SharedPref.pref.getInt('index');
      checkFirstSeen();
    }
  }

  goButton() {
    return Container(
      width: Constants.sw * 0.5,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: currentTapIndex != 2 && purushIndex != 50
                ? MaterialStateProperty.all(Color.fromARGB(255, 0, 20, 150))
                : MaterialStateProperty.all(Color.fromARGB(255, 10, 120, 255).withOpacity(0.5)),
            foregroundColor: currentTapIndex != 2 && purushIndex != 50
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(Color.fromARGB(150, 0, 20, 150)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(width: 0.1),
                borderRadius: BorderRadius.circular(Constants.sh * 0.035))),
          ),
          onPressed: () {
            print("--------------------");
            if (currentTapIndex != 2 &&
                purushIndex != 50 &&
                mahilaIndex != 50) {
              SharedPref.pref.setInt('index', currentTapIndex);

              checkFirstSeen();
            }
          },
          child: Align(alignment: Alignment.center, child: Text("Go !!!"))),
    );
  }

  Widget purushNamesChips() {
    return Container(
        height: Constants.sh * 0.5,
        width: Constants.sw,
        margin: EdgeInsets.all(20),
        child: GridView.builder(
            itemCount: Constants.names.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, mainAxisExtent: 50),
            itemBuilder: (c, i) {
              return singleNameChip(i);
            }));
  }

  Widget mahilaNamesChips() {
    return Container(
        height: Constants.sh * 0.5,
        width: Constants.sw,
        margin: EdgeInsets.all(20),
        child: GridView.builder(
            itemCount: Constants.mahilasNames.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, mainAxisExtent: 50),
            itemBuilder: (c, i) {
              return singleMahilaNameChip(i);
            }));
  }

  Widget singleNameChip(int i) {
    String name = Constants.names[i];

    return Container(
      width: Constants.sw * 0.4,
      height: Constants.sh * 0.07,
      margin: EdgeInsets.all(5),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: purushIndex == i
                ? MaterialStateProperty.all(Colors.purple)
                : MaterialStateProperty.all(Colors.purple.shade100),
            foregroundColor: purushIndex == i
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(Colors.purple),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(width: 0.1),
                borderRadius: BorderRadius.circular(Constants.sh * 0.035))),
          ),
          onPressed: () {
            setState(() {
              products!.setPurushIndexFun(i);
              purushIndex = products!.getPurushIndexFun();
            });
          },
          child: Align(alignment: Alignment.center, child: Text(name))),
    );
  }

  Widget singleMahilaNameChip(int i) {
    String name = Constants.mahilasNames[i];

    return Container(
      width: Constants.sw * 0.4,
      height: Constants.sh * 0.07,
      margin: EdgeInsets.all(5),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: mahilaIndex == i
                ? MaterialStateProperty.all(Colors.green)
                : MaterialStateProperty.all(Colors.green.shade100),
            foregroundColor: mahilaIndex == i
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(width: 0.1),
                borderRadius: BorderRadius.circular(Constants.sh * 0.035))),
          ),
          onPressed: () {
            setState(() {
              products!.setMahilaIndexFun(i);
              mahilaIndex = products!.getMahilaIndexFun();
            });
          },
          child: Align(alignment: Alignment.center, child: Text(name))),
    );
  }
}
