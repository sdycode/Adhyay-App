import 'package:ads_code_library_issue/ads_unitid.dart';
import 'package:ads_code_library_issue/providers/provider.dart';
import 'package:ads_code_library_issue/providers/sharedPref.dart';
import 'package:ads_code_library_issue/widgets/app_drawer.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constants.dart';

class Screen1 extends StatefulWidget {
  Products products;
  Screen1(
    this.products,
  );

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final GlobalKey expandedKey = GlobalKey();
  // final ValueNotifier<double> expandedHeight = ValueNotifier<double>(-1);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  Products? products;
  int ind = 0;
  int ajcheadhayindex = 0;
  int pathnooffirst = 0;
  int index = 0;
  int readingadyayNo = 0;
  String respose = "";
  String completeMessage = "";
  String durgaCompleteMessage = "";
  double statusBarHeight = 25;
  bool showAd = false;
  bool showSingleActualAdhyay = true;
  String selectedNo = "१,२,३";
  String pathNumber = Constants.pathNos[0];
  String emoj = " 🌹🙏🏻🙏🏻";
  String name = Constants.names[0];
  String adhyay = "श्री स्वामी चरित्र सारामृत अध्याय क़. - ";
  String vachan = " चे वाचन झाले ";
  String totalmsg = "";
  String totalDurgaMsg = "";
  String mali = "";
  int pathNo = 1;
  int date = 1;
  int year = 2021;
  int mahilaIndex = 0;
  String month = "डिसेंबर";
  int currentTapIndex = 0;
  double bannerAdHeight = 0;
  String saptashatiPathNo = "";
  String selectedPathNo = " ";
  String mahilaname = Constants.mahilasNames[0];
  List adhyayVachaNames = ["अध्याय वाचा", "संदेश पाठवा"];
  List pathVachaNames = ["पाठ वाचा", "संदेश पाठवा"];
  bool openAdhyay = false;
  bool isAdLoaded = false;
  bool openPath = false;
  double tempHeight = Constants.sh * 0.1;

  double expandPaintHeight = 400;
 
  List<int> years = [2021, 2022];
  int pathIndex = 0;
  int currentMaleIndex = 0;
  // int mahilaIndex = 0;
  StateSetter setAdhyayMessagePage = (d) {};

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    refresh(widget.products);

    name = Constants.names[widget.products.getPurushIndexFun()];
      int cindex = Constants.names.indexOf(name);
          resetAdhyayMessagebyTempSelectedPerson(cindex);
mahilaname =  Constants.mahilasNames[widget.products.getMahilaIndexFun()];
           int mindex = Constants.mahilasNames.indexOf(mahilaname);
                  resetPathMessagebyTempSelectedPerson(mindex);
                  pathNumber = Constants.pathNos[ind];
                   if (ind == 0) {
            selectedPathNo = "कुलदेवतेची जपमाळ ते रात्रि सूक्त ";
          } else if (ind == 14) {
            selectedPathNo = "सर्व स्तोत्र,सिद्धकुञ्जिका स्तोत्र ";
          } else {
            selectedPathNo = "पाठ क्र. - $pathNumber";
          }
    if ((SharedPref.pref.getInt('index') ?? 0) < 2) {
      currentTapIndex = SharedPref.pref.getInt('index') ?? 0;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
;
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    Products p = Provider.of<Products>(context);
    pathIndex = SharedPref.pref.getInt('index') ?? 0;

    if (expandedKey.currentContext != null) {
      RenderBox box =
          expandedKey.currentContext!.findRenderObject() as RenderBox;
      expandPaintHeight = box.size.height;
    }

    Constants.sh = sh;
    Constants.sw = sw;
    tempHeight = Constants.sh * 0.1;

    statusBarHeight = MediaQuery.of(context).padding.top;
    totalmsg = adhyay + selectedNo + vachan + name + emoj;
    mali = selectedNo + " झाला - " + name + emoj;
    print("selectedPathNo $selectedPathNo"); 
    totalDurgaMsg =
        saptashatiPathNo + selectedPathNo + vachan + "\n-" + mahilaname + emoj;

    final tabs = [personalMsg(), durgaSaptashaiMsg()];
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      resizeToAvoidBottomInset: true,
      body: Container(
        height: sh,
        width: sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              key: expandedKey,
              child: tabs[currentTapIndex],
            ),

            // Spacer(),
            Container(
              height: Constants.sh * 0.1,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  bottomIconImage(0, sw, sh),
                  currentTapIndex == 0
                      ? adhyayButtonOptions()
                      : durgaPathButtonOptions(),
                  bottomIconImage(1, sw, sh)
                ],
              ),
            ),
      
          ],
        ),
      ),
    );
  }

  menuButton() {
    return Container(
        height: Constants.sh * 0.06,
        width: Constants.sw * 0.1,
        child: InkWell(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
            // Scaffold.of(context).openDrawer();
          },
          child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Container(
                  height: Constants.sh * 0.06,
                  margin: EdgeInsets.all(2),
                  child: Icon(
                    Icons.menu,
                  ))),
        ));
  }

  personalMsg() {
    return Container(
        child: openAdhyay ? adhyayReadPage() : adhyayMessagePage());
  }

  namesList() {
    return DropdownButton<String>(
      value: name,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          name = newValue!;

          int cindex = Constants.names.indexOf(name);
          resetAdhyayMessagebyTempSelectedPerson(cindex);

          // }
        });
      },
      items: Constants.names.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  nosList() {
    return DropdownButton<String>(
      value: selectedNo,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedNo = newValue!;
        });
      },
      items: Constants.nos.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  emojisList() {
    return DropdownButton<String>(
      value: emoj,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          emoj = newValue!;
        });
      },
      items: Constants.emojis.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  monthsList() {
    return DropdownButton<String>(
      value: month,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          month = newValue!;
        });
      },
      items: Constants.months.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  pathNoList() {
    return DropdownButton<int>(
      value: pathNo,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (int? newValue) {
        setState(() {
          pathNo = newValue!;
        });
      },
      items: Constants.pathNosList.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text("$value"),
        );
      }).toList(),
    );
  }

  dateList() {
    return DropdownButton<int>(
      value: date,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (int? newValue) {
        setState(() {
          date = newValue!;
        });
      },
      items: Constants.dates.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text("$value"),
        );
      }).toList(),
    );
  }

  yearList() {
    return DropdownButton<int>(
      value: year,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (int? newValue) {
        setState(() {
          year = newValue!;
        });
      },
      items: years.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text("$value"),
        );
      }).toList(),
    );
  }

  mahilaNamesList() {
    return DropdownButton<String>(
      value: mahilaname,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          print("m name ${newValue}");
          // mahilaname = newValue!;
          mahilaIndex = Constants.mahilasNames.indexOf(newValue!);
          mahilaname = Constants.mahilasNames[mahilaIndex];
          pathnooffirst = getPathIndexForFirstMahila();

          ind = getPathNoOfSelectedMahila(mahilaIndex);
          pathNumber = Constants.pathNos[ind];
          if (ind == 0) {
            selectedPathNo = "कुलदेवतेची जपमाळ ते रात्रि सूक्त ";
          } else if (ind == 14) {
            selectedPathNo = "सर्व स्तोत्र,सिद्धकुञ्जिका स्तोत्र ";
          } else {
            selectedPathNo = "पाठ क्र. - $pathNumber";
          }

          print("new ind name ${mahilaname} & $ind");
        });
      },
      items:
          Constants.mahilasNames.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  mahilnosList() {
    return DropdownButton<String>(
      value: pathNumber,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          pathNumber = newValue!;
          selectedPathNo = "पाठ क्र. - $pathNumber"; 
        });
      },
      items: Constants.pathNos.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  durgaSaptashaiMsg() {
    return Container(child: openPath ? pathReadPage() : pathMessagePage());
    // return Container(
    //   height: Constants.sh * 0.9 - statusBarHeight - bannerAdHeight - 56,
    //   width: Constants.sw,
    //   child:
    //       Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    //     Align(
    //       alignment: Alignment.center,
    //       child: Text(
    //         totalDurgaMsg,
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontSize: 25),
    //       ),
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         ElevatedButton.icon(
    //             onPressed: () {
    //               if (selectedNo == "११ माळी जप") {
    //                 mali = selectedNo + " झाला - " + name + emoj;
    //                 FlutterClipboard.copy(mali);
    //               } else {
    //                 totalmsg = adhyay + selectedNo + vachan + name + emoj;
    //                 FlutterClipboard.copy(totalmsg);
    //               }
    //             },
    //             icon: Icon(Icons.copy),
    //             label: Text("Copy")),
    //         ElevatedButton.icon(
    //             style: ButtonStyle(
    //               backgroundColor:
    //                   MaterialStateProperty.all<Color>(Colors.green),
    //             ),
    //             onPressed: () async {
    //               if (selectedNo == "११ माळी जप") {
    //                 mali = selectedNo + " झाला - " + name + emoj;
    //                 respose =
    //                     (await flutterShareMe.shareToWhatsApp(msg: mali))!;
    //               } else {
    //                 totalmsg = adhyay + selectedNo + vachan + name + emoj;
    //                 respose =
    //                     (await flutterShareMe.shareToWhatsApp(msg: totalmsg))!;
    //               }
    //             },
    //             icon: const Icon(MdiIcons.whatsapp),
    //             label: Text("Send")),
    //       ],
    //     ),
    //     Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [mahilaNamesList(), mahilnosList(), emojisList()])
    //   ]),
    // );
  }

  Widget bottomIconImage(int i, double sw, double sh) {
    return InkWell(
        onTap: () {
          setState(() {
            currentTapIndex = i;
            if (expandedKey.currentContext != null) {
              RenderBox box =
                  expandedKey.currentContext!.findRenderObject() as RenderBox;
              expandPaintHeight = box.size.height;
            }

            if (i == 0 && (tempHeight - 5) > Constants.sh * 0.1) {
              tempHeight -= 5;
            } else {
              tempHeight += 5;
            }
          });
        },
        child:
            // CircleAvatar(
            //   radius: sw * 0.15*0.5, backgroundImage: Image.asset(Constants.iconImgNames[i])

            // ),
            Container(
          width: sw * 0.15,
          height: sw * 0.15,
          child: CircleAvatar(
            backgroundColor:
                currentTapIndex == i ? Colors.black : Colors.transparent,
            radius: sw * 0.15 * 0.5,
            child: CircleAvatar(
                radius: sw * 0.15 * 0.45,
                backgroundImage: AssetImage((Constants.iconImgNames[i]))),
          ),
        )
        );
  }

  void refresh(Products products) {
    setState(() {
      mahilaIndex = products.getMahilaIndexFun();
      mahilaname = Constants.mahilasNames[mahilaIndex];
    });
  }

  Widget adhyayVachaButton(bool change, double sw, double sh) {
    return Container(
      height: sh * 0.07,
      width: sw * 0.31,
      margin: EdgeInsets.all(sw * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sh * 0.035),
        boxShadow: [
          change == openAdhyay
              ? BoxShadow(
                  color: change
                      ? Colors.brown.withOpacity(0.5)
                      : Color.fromARGB(255, 0, 20, 150),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 1), // changes position of shadow
                )
              : BoxShadow(),
        ],
      ),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: change
                ? MaterialStateProperty.all(Colors.deepOrange)
                : MaterialStateProperty.all(Color.fromARGB(255, 0, 20, 150)),
            foregroundColor: change
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                // side: BorderSide(width: 0.1),
                borderRadius: BorderRadius.circular(sh * 0.035))),
          ),
          onPressed: () {
            setState(() {
              if (change) {
                openAdhyay = true;
              } else {
                openAdhyay = false;
              }
            });
          },
          child: Align(
              alignment: Alignment.center,
              child: Text(adhyayVachaNames[change ? 0 : 1]))),
    );
  }

  Widget pathVachaButton(bool change, double sw, double sh) {
    return Container(
      height: sh * 0.07,
      width: sw * 0.31,
      margin: EdgeInsets.all(sw * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sh * 0.035),
        boxShadow: [
          change == openPath
              ? BoxShadow(
                  color: change
                      ? Colors.brown.withOpacity(0.5)
                      : Color.fromARGB(255, 0, 20, 150),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 1), // changes position of shadow
                )
              : BoxShadow(),
        ],
      ),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: change
                ? MaterialStateProperty.all(Colors.brown)
                : MaterialStateProperty.all(Color.fromARGB(255, 0, 20, 150)),
            foregroundColor: change
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                // side: BorderSide(width: 0.1),
                borderRadius: BorderRadius.circular(sh * 0.035))),
          ),
          onPressed: () {
            setState(() {
              if (change) {
                openPath = true;
              } else {
                openPath = false;
              }
            });
          },
          child: Align(
              alignment: Alignment.center,
              child: Text(pathVachaNames[change ? 0 : 1]))),
    );
  }

  Widget adhyayMessagePage() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setAdhyayMessagePageTemp) {
      setAdhyayMessagePage = setAdhyayMessagePageTemp;
      return Container(
        height: expandPaintHeight,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          //  openAdhyay ? readAdhyayWidget() : adhyayMessagePage(),
          Align(alignment: Alignment.centerLeft, child: menuButton()),
          Align(
            alignment: Alignment.center,
            child: Text(
              selectedNo == "११ माळी जप" ? mali : totalmsg,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Spacer(),
  
          Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    if (selectedNo == "११ माळी जप") {
                      mali = selectedNo + " झाला - " + name + emoj;
                      FlutterClipboard.copy(mali);
                    } else {
                      totalmsg = adhyay + selectedNo + vachan + name + emoj;
                      FlutterClipboard.copy(totalmsg);
                    }
                  },
                  icon: Icon(Icons.copy),
                  label: Text("Copy")),
              ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () async {
                    name = Constants.names[widget.products.getPurushIndexFun()];
                    int cindex = Constants.names.indexOf(name);
                    resetAdhyayMessagebyTempSelectedPerson(cindex);
                  },
                  icon: const Icon(MdiIcons.restore),
                  label: Text("Reset")),
              ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () async {
                    if (selectedNo == "११ माळी जप") {
                      mali = selectedNo + " झाला - " + name + emoj;
                      respose =
                          (await flutterShareMe.shareToWhatsApp(msg: mali))!;
                    } else {
                      totalmsg = adhyay + selectedNo + vachan + name + emoj;
                      respose = (await flutterShareMe.shareToWhatsApp(
                          msg: totalmsg))!;
                    }
                  },
                  icon: const Icon(MdiIcons.whatsapp),
                  label: Text("Send")),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [namesList(), nosList(), emojisList()]),
        ]),
      );
    });
  }

  Widget adhyayButtonOptions() {
    return Container(
      height: Constants.sh * 0.1,
      width: Constants.sw * 0.7,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        adhyayVachaButton(true, Constants.sw, Constants.sh),
        adhyayVachaButton(false, Constants.sw, Constants.sh)
      ]),
    );
  }

  Widget durgaPathButtonOptions() {
    return Container(
      height: Constants.sh * 0.1,
      width: Constants.sw * 0.7,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        pathVachaButton(true, Constants.sw, Constants.sh),
        pathVachaButton(false, Constants.sw, Constants.sh)
      ]),
    );
  }

  Widget adhyayReadPage() {
    name = Constants.names[widget.products.getPurushIndexFun()];
    int cindex = Constants.names.indexOf(name);
    resetAdhyayMessagebyTempSelectedPerson(cindex);

    if (cindex == 0) {
      return Container();
    } else {
      return Container(
          height: expandPaintHeight,
          child: Column(
            children: [
              Container(
                height: Constants.sh * 0.06,
                child: Row(
                  children: [
                    menuButton(),
                    Container(
                      width: Constants.sw * 0.3,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("आजचे अध्याय"),
                      ),
                    ),
                    Container(
                        width: Constants.sw * 0.4,
                        height: Constants.sh * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  showSingleActualAdhyay = false;
                                  readingadyayNo = (ajcheadhayindex) * 3;
                                });
                              },
                              child: Container(
                                height: Constants.sh * 0.05,
                                child: FittedBox(
                                  child: CircleAvatar(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "${(ajcheadhayindex) * 3 + 1}"))),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  showSingleActualAdhyay = false;
                                  readingadyayNo = (ajcheadhayindex) * 3 + 1;
                                });
                              },
                              child: Container(
                                height: Constants.sh * 0.05,
                                child: FittedBox(
                                  child: CircleAvatar(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "${(ajcheadhayindex) * 3 + 2}"))),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  showSingleActualAdhyay = false;
                                  readingadyayNo = (ajcheadhayindex) * 3 + 2;
                                });
                              },
                              child: Container(
                                height: Constants.sh * 0.05,
                                child: FittedBox(
                                  child: CircleAvatar(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "${(ajcheadhayindex) * 3 + 3}"))),
                                ),
                              ),
                            ),
                          ],
                        )),
                    InkWell(
                      onTap: () {
                        setState(() {
                          showSingleActualAdhyay = !showSingleActualAdhyay;
                        });
                      },
                      child: Container(
                          width: Constants.sw * 0.2 - 10,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: !showSingleActualAdhyay
                                ? Colors.lightBlue
                                : Colors.transparent,
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(
                                Constants.sh * 0.06 * 0.5),
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text("अध्याय",
                                      style: TextStyle(
                                          color: !showSingleActualAdhyay
                                              ? Colors.white
                                              : Colors.black))))),
                    )
                  ],
                ),
              ),
              showSingleActualAdhyay
                  ? allAdhyayButtonList(
                      (expandPaintHeight - Constants.sh * 0.06).abs())
                  : ActualAdhayTextPage(
                      (expandPaintHeight - Constants.sh * 0.06).abs())
            ],
          ));
    }
  }

  void resetAdhyayMessagebyTempSelectedPerson(int personIndex) {
    // setAdhyayMessagePage
    if (mounted) {
      setState(() {
        if (personIndex == 0) {
          selectedNo = Constants.nos[0];
        } else {
          personIndex = Constants.namesNoAnkush.indexOf(name);

          final birthday = DateTime(2021, 12, 20);
          final d = DateTime.now();
          final difference = d.difference(birthday).inDays - 1;
          // print("differennc ${difference}");
          int firstAdhyayPersonIndex = 6 - ((difference) % 7);
          // print("first $firstAdhyayPersonIndex");

          if (firstAdhyayPersonIndex <= personIndex) {
            ind = personIndex - firstAdhyayPersonIndex;
          } else {
            ind = personIndex - firstAdhyayPersonIndex + 7;
          }

          selectedNo = Constants.noAnkushNos[ind];
          ajcheadhayindex = ind;
          print("se;ee $selectedNo");
        }
      });
    } else {}
  }

  allAdhyayButtonList(double h) {
    return Container(
      height: h * 0.98,
      padding: EdgeInsets.all(15),
      child: GridView.builder(
          itemCount: 21,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: h * 0.1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12),
          itemBuilder: (c, i) {
            return Container(
              margin: EdgeInsets.all(5),
              child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(width: 0.1),
                        borderRadius:
                            BorderRadius.circular(Constants.sh * 0.025))),
                  ),
                  onPressed: () {
                    setState(() {
                      showSingleActualAdhyay = !showSingleActualAdhyay;
                      readingadyayNo = i;
                    });
                  },
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("अध्याय ${i + 1}"))),
            );
          }),
    );
  }

  ActualAdhayTextPage(double h) {
    print("carasouse slided @ $readingadyayNo -------------------------");
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter pageState) {
      return Container(
          color: Colors.amber.shade300.withOpacity(0.50),
          height: h,
          child: CarouselSlider.builder(
            itemCount: Constants.newAds.length,
            options: CarouselOptions(
                pageSnapping: true,
                onPageChanged: (d, reason) {
                  print("new slided index $d & reading $readingadyayNo");
                  setState(() {
                    readingadyayNo = d;
                  });
                },
                height: h,
                viewportFraction: 1.0,
                initialPage: readingadyayNo),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: h * 0.08,
                      padding: EdgeInsets.all(5),
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: h * 0.07,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 2.0,
                                    color: Colors.red.shade900,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "अध्याय  - ${readingadyayNo + 1} ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ))),
                  Spacer(),
                  Container(
                      height: h * 0.92,
                      child: RawScrollbar(
                        thumbColor: Colors.amber,
                        thickness: 8,
                        radius: Radius.circular(4),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              Constants.newAds[readingadyayNo],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      )
                      // ListView.builder(
                      //
                      ),
                  Spacer(),
                ],
              );
            },
          ));
    });
  }

  Widget pathReadPage() {
    return Center(
        child: Text("कृपया प्रतीक्षा करा !!!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }

  Widget pathMessagePage() {
    return Container(
      height: expandPaintHeight,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //  openAdhyay ? readAdhyayWidget() : adhyayMessagePage(),
        Align(alignment: Alignment.centerLeft, child: menuButton()),
        Align(
          alignment: Alignment.center,
          child: Text(
            totalDurgaMsg,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
        ),
        Spacer(),

        Spacer(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
                onPressed: () {
             
                   
                    FlutterClipboard.copy(totalDurgaMsg);
                  
                },
                icon: Icon(Icons.copy),
                label: Text("Copy")),
            ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
                onPressed: () async {
                  mahilaname = Constants
                      .mahilasNames[widget.products.getMahilaIndexFun()];
                  int cindex = Constants.mahilasNames.indexOf(mahilaname);
                  resetPathMessagebyTempSelectedPerson(cindex);
                },
                icon: const Icon(MdiIcons.restore),
                label: Text("Reset")),
            ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () async {
               
                  
                    respose =
                        (await flutterShareMe.shareToWhatsApp(msg: totalDurgaMsg))!;
                  
                },
                icon: const Icon(MdiIcons.whatsapp),
                label: Text("Send")),
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [mahilaNamesList(), mahilnosList(), emojisList()]),
      ]),
    );

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Align(
        alignment: Alignment.center,
        child: Text(
          selectedNo == "११ माळी जप" ? mali : totalmsg,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                if (selectedNo == "११ माळी जप") {
                  mali = selectedNo + " झाला - " + name + emoj;
                  FlutterClipboard.copy(mali);
                } else {
                  totalmsg = adhyay + selectedNo + vachan + name + emoj;
                  FlutterClipboard.copy(totalmsg);
                }
              },
              icon: Icon(Icons.copy),
              label: Text("Copy")),
          ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () async {
                if (selectedNo == "११ माळी जप") {
                  mali = selectedNo + " झाला - " + name + emoj;
                  respose = (await flutterShareMe.shareToWhatsApp(msg: mali))!;
                } else {
                  totalmsg = adhyay + selectedNo + vachan + name + emoj;
                  respose =
                      (await flutterShareMe.shareToWhatsApp(msg: totalmsg))!;
                }
              },
              icon: const Icon(MdiIcons.whatsapp),
              label: Text("Send")),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        pathNoList(),
      ]),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [dateList(), monthsList(), yearList()])
    ]);
  }

  void resetPathMessagebyTempSelectedPerson(int personIndex) {
    if (mounted) {
      setState(() {
        print(
            "path --------------------------------------------------------------");

        personIndex = Constants.mahilasNames.indexOf(mahilaname);
        print("path reset mahila index $personIndex");
        final birthday = DateTime(2021, 12, 20);
        final d = DateTime.now();
        final diff = d.difference(birthday).inDays - 6;

        int selectedMahilaNameIndex = 14 - (diff % 15);
        pathnooffirst = getPathIndexForFirstMahila();

        ind = getPathNoOfSelectedMahila(personIndex);
        pathNumber = Constants.pathNos[ind];
              if (ind == 0) {
            selectedPathNo = "कुलदेवतेची जपमाळ ते रात्रि सूक्त ";
          } else if (ind == 14) {
            selectedPathNo = "सर्व स्तोत्र,सिद्धकुञ्जिका स्तोत्र ";
          } else {
            selectedPathNo = "पाठ क्र. - $pathNumber";
          }
        print("pathh $pathNumber");
      });
    } else {}
  }

  int getPathIndexForFirstMahila() {
    final birthday = DateTime(2021, 12, 20);
    final d = DateTime.now();
    final diff = d.difference(birthday).inDays - 6 + 7;
    int dd = diff % 15;
    print("dd path $dd");
    return dd;
  }

  int getPathNoOfSelectedMahila(int pIndex) {
    int ans = 0;
    ans = (pathnooffirst + pIndex) % 15;

    return ans;
  }

  // mahilNamesList() {
  //      return DropdownButton<String>(
  //     value: mahilaname,
  //     icon: const Icon(Icons.arrow_downward),
  //     elevation: 16,
  //     style: const TextStyle(color: Colors.deepPurple),
  //     underline: Container(
  //       height: 2,
  //       color: Colors.deepPurpleAccent,
  //     ),
  //     onChanged: (String? newValue) {
  //       setState(() {
  //         name = newValue!;

  //         int cindex = Constants.names.indexOf(name);
  //         resetAdhyayMessagebyTempSelectedPerson(cindex);

  //         // }
  //       });
  //     },
  //     items: Constants.mahilasNames.map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //   );

  // }

}
