import 'package:ads_code_library_issue/providers/provider.dart';
import 'package:ads_code_library_issue/providers/sharedPref.dart';
import 'package:ads_code_library_issue/widgets/app_drawer.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController pathnocontroller = TextEditingController();
  bool showAd = false;
  DateTime d = DateTime.now();
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  List<String> buttonNames = ["स्वामी चरित्र", "दुर्गा सप्तशती"];
  int currentIndex = 0;
  String name = "गणेश पाखले";

  int selectedNameIndex = 1;
  String mahilaName = Constants.mahilasNames[0];
  int selectedMahilaNameIndex = 1;
  bool isAnkushRead = false;
  String completeMessage = "";
  String durgaCompleteMessage = "";
  bool showAdInAdmin = false;
  late Products products;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pathnocontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    products = Provider.of<Products>(context);
    getCompleteMessage();
    getDurgaCompleteMessage();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: appBar(),
      body: RefreshIndicator(
        onRefresh: () {
          getCompleteMessage();

          return getCompleteMessage();
        },
        child: Container(
          height: sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(

                  // height: sh * 0.63,
                  child: currentIndex == 0
                      ? swamiPage(sh, sw)
                      : durgaPage(sh, sw)),
              Container(
                height: sh * 0.07,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    textRoundButton(0, sw, sh),
                    textRoundButton(1, sw, sh)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textRoundButton(int i, double sw, double sh) {
    return Container(
      height: sh * 0.07,
      width: sw * 0.4,
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: currentIndex == i
                ? MaterialStateProperty.all(Colors.purple)
                : MaterialStateProperty.all(Colors.purple.shade100),
            foregroundColor: currentIndex == i
                ? MaterialStateProperty.all(Colors.white)
                : MaterialStateProperty.all(Colors.purple),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(width: 0.1),
                borderRadius: BorderRadius.circular(sh * 0.035))),
          ),
          onPressed: () {
            setState(() {
              currentIndex = i;
            });
          },
          child:
              Align(alignment: Alignment.center, child: Text(buttonNames[i]))),
    );
  }

  Widget swamiPage(double sh, double sw) {
    return Container(
      height: sh,
      width: sw,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Stack(
              children: [
                Container(
                    width: sw,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(
                              10.0) //                 <--- border radius here
                          ),
                    ),
                    child: FittedBox(child: Text(completeMessage))),
                Align(
                  alignment: Alignment.topRight,
                  child: changeAdhyayPathNoWidget(sh, sw),
                )
              ],
            )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text("१,२,३"),
            //     namesList(),

            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    // d = DateTime.now();
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020, 12, 20),
                      lastDate: DateTime(2023),
                    ).then((v) {
                      d = v!;
                      setState(() {
                        getCompleteMessage();
                      });

                      return d;
                    });
                    print("${d.day} day");
                  },
                  child: Icon(Icons.calendar_today),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      getCompleteMessage();
                      FlutterClipboard.copy(completeMessage);
                    },
                    icon: Icon(Icons.copy),
                    label: Text("Copy")),
                ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () async {
                      getCompleteMessage();
                      var respose = (await flutterShareMe.shareToWhatsApp(
                          msg: completeMessage))!;
                    },
                    icon: const Icon(MdiIcons.whatsapp),
                    label: Text("Send")),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      resetSwamiMessage();
                    },
                    child: Text("Reset")),
              ],
            )
          ]),
    );
  }

  Widget durgaPage(double sh, double sw) {
    return Container(
      height: sh,
      width: sw,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(
                              10.0) //                 <--- border radius here
                          ),
                    ),
                    child: FittedBox(child: Text(durgaCompleteMessage)))),
            // Container(
            //   height: sh * 0.08,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Text("अध्याय १"),
            //       mahilaNamesList(),

            //     ],
            //   ),
            // ),
            Container(
              height: sh * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      // DateTime d = DateTime.now();
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020, 12, 20),
                        lastDate: DateTime(2023),
                      ).then((v) {
                        setState(() {
                          d = v!;
                          print("${d.day} complete day ");
                          getDurgaCompleteMessage();
                        });
                      });
                    },
                    child: Icon(Icons.calendar_today),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        getDurgaCompleteMessage();
                        FlutterClipboard.copy(durgaCompleteMessage);
                      },
                      icon: Icon(Icons.copy),
                      label: Text("Copy")),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () async {
                        getDurgaCompleteMessage();
                        var respose = (await flutterShareMe.shareToWhatsApp(
                            msg: durgaCompleteMessage))!;
                      },
                      icon: const Icon(MdiIcons.whatsapp),
                      label: Text("Send")),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () {
                        resetDurgaMessage();
                      },
                      child: Text("Reset")),
                ],
              ),
            )
          ]),
    );
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
          if (isAnkushRead) {
            selectedNameIndex = Constants.names.indexOf(newValue!);
            print("index $selectedNameIndex");
          } else {
            selectedNameIndex = Constants.namesNoAnkush.indexOf(newValue!);
            print("index $selectedNameIndex");
          }

          name = newValue;
        });
      },
      items: isAnkushRead
          ? Constants.names.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
          : Constants.namesNoAnkush
              .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
    );
  }

  mahilaNamesList() {
    return DropdownButton<String>(
      value: mahilaName,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedMahilaNameIndex = Constants.mahilasNames.indexOf(newValue!);
          print("index $selectedMahilaNameIndex");

          mahilaName = newValue;
          getDurgaCompleteMessage();
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

  resetSwamiMessage() {
    d = DateTime.now();

    setState(() {
      getCompleteMessage();
    });
  }

  getCompleteMessage() {
    print("----------------------------------------");
    final birthday = DateTime(2021, 12, 20);
    // final d = DateTime.now();
    final difference = d.difference(birthday).inDays - 1;
    print("differennc ${difference}");
    selectedNameIndex = 6 - ((difference) % 7);
    print("index ${selectedNameIndex} ");

    name = Constants.namesNoAnkush[selectedNameIndex];
    print("name ${name}");
    print("======================================");
    completeMessage = d.day.toString() +
        " " +
        Constants.months[d.month - 1] +
        " " +
        d.year.toString() +
        "\nपाठ क्रमांक ${difference + 2 + products.getAdhaypathno()} \nश्री स्वामी  चरित्र 700 श्लोकी\n" +
        "श्री स्वामी समर्थ 11 माळी जप अंकुश येवले\n" +
        "\nअध्याय 1 ते 3 " +
        Constants.namesNoAnkush[selectedNameIndex] +
        "\nअध्याय 4 ते 6 " +
        Constants.namesNoAnkush[(selectedNameIndex + 1) % 7] +
        "\nअध्याय 7 ते 9 " +
        Constants.namesNoAnkush[(selectedNameIndex + 2) % 7] +
        "\nअध्याय 10 ते 12 " +
        Constants.namesNoAnkush[(selectedNameIndex + 3) % 7] +
        "\nअध्याय 13 ते 15 " +
        Constants.namesNoAnkush[(selectedNameIndex + 4) % 7] +
        "\nअध्याय 16 ते 18 " +
        Constants.namesNoAnkush[(selectedNameIndex + 5) % 7] +
        "\nअध्याय 19 ते 21 " +
        Constants.namesNoAnkush[(selectedNameIndex + 6) % 7];
  }

  getDurgaCompleteMessage() {
    print("----------------------------------------");
    print("${d.day} in get fun ");
    final birthday = DateTime(2020, 12, 20);
    // final d = DateTime.now();
    final diff = d.difference(birthday).inDays - 6;
    print("differennc ${diff}");
    selectedMahilaNameIndex = 14 - (diff % 15);
    print("index ${selectedMahilaNameIndex} ");

    mahilaName = Constants.mahilasNames[selectedMahilaNameIndex];
    print("mahila name ${mahilaName}");
    print("======================================");

    durgaCompleteMessage = d.day.toString() +
        " " +
        Constants.months[d.month - 1] +
        " " +
        d.year.toString() +
        "\nपाठ क्रमांक - ${diff - (373 - 86)} \n\n" +
        "कुलदेवतेची जपमाळ ते रात्रि सूक्त : ${Constants.mahilasNames[(selectedMahilaNameIndex + 14) % 15]}\n " +
        "\nअध्याय 1 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex)] +
        "\nअध्याय 2 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 1) % 15] +
        "\nअध्याय 3 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 2) % 15] +
        "\nअध्याय 4 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 3) % 15] +
        "\nअध्याय 5 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 4) % 15] +
        "\nअध्याय 6 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 5) % 15] +
        "\nअध्याय 7 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 6) % 15] +
        "\nअध्याय 8 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 7) % 15] +
        "\nअध्याय 9 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 8) % 15] +
        "\nअध्याय 10 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 9) % 15] +
        "\nअध्याय 11 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 10) % 15] +
        "\nअध्याय 12 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 11) % 15] +
        "\nअध्याय 13 : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 12) % 15] +
        "\n\nसर्व स्तोत्र,सिद्धकुञ्जिका स्तोत्र,देवीचा जयजयकार : " +
        Constants.mahilasNames[(selectedMahilaNameIndex + 13) % 15];
  }

  void resetDurgaMessage() {
    d = DateTime.now();

    setState(() {
      getDurgaCompleteMessage();
    });
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
          "Admin ${products.getAdhaypathnosignisPlusOrNot()} // ${products.getAdhaypathno()}"),
      flexibleSpace: Container(
        color: Colors.lightGreen,
      ),
    );
  }

  changeAdhyayPathNoWidget(double sh, double sw) {
    return Container(
      height: sw * 0.25,
      width: sw * 0.2,
      margin: EdgeInsets.all(sh * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: sw * 0.1,
            width: sw * 0.2,
            child: TextField(
                controller: pathnocontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (no) {
                  if (no.isNotEmpty) {
                    if (int.tryParse(no) != null) {
                      int n = int.parse(no);
                      products.setAdhaypathno(n);
                    } else {
                      products.setAdhaypathno(0);
                    }
                  } else {
                    products.setAdhaypathno(0);
                  }
                }),
          ),
          // Container(
          //     height: sw * 0.15,
          //     width: sw * 0.2,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         FittedBox(
          //           child: InkWell(
          //             onTap: () => products.setAdhaypathnoSign(true),
          //             child: Icon(
          //               Icons.add_circle,
          //               size: products.getAdhaypathnosignisPlusOrNot()
          //                   ? sw * 0.08
          //                   : sw * 0.06,

          //               color: products.getAdhaypathnosignisPlusOrNot()
          //                   ? Colors.green
          //                   : Colors.red,
          //             ),
          //           ),
          //         ),
          //         FittedBox(
          //           child: InkWell(
          //             onTap: () => products.setAdhaypathnoSign(false),
          //             child: Icon(
          //               Icons.remove_circle,
          //               size: products.getAdhaypathnosignisPlusOrNot()
          //                   ? sw * 0.06
          //                   : sw * 0.08,
          //               color: products.getAdhaypathnosignisPlusOrNot()
          //                   ? Colors.red
          //                   : Colors.green,
          //             ),
          //           ),
          //         )
          //       ],
          //     )),
      
        ],
      ),
    );
  }
}

/* 


Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                isAnkushRead
                    ? Text("अंकुश अध्याय सुद्धा वाचेल !!!")
                    : Text("अंकुश फक्त 11 माळी जप करेल "),
                Switch(
                    value: isAnkushRead,
                    onChanged: (bool b) {
                      setState(() {
                        isAnkushRead = b;
                      });
                    })
              ],
            ),

            */

/*


3 जानेवारी 2022
पाठ क्रमांक. 86
*कुलदेवतेची जपमाळ ते रात्रि सूक्त
सौ मनीषा अमृतकर
अध्याय 1:सौ लक्ष्मी खोडके
अध्याय 2:कविता येवले
अध्याय 3:सौ सुनिता येवले
अध्याय 4:सौ वर्षा सोनजे
अध्याय 5:ज्योती पुराणिक
 अध्याय 6: गणेश पाखले
अध्याय 7:उषा ततार 
अध्याय 8:सौ नंदा कोकाटे
 अध्याय 9:कु योगिता भदाणे 
अध्याय 10:कु कल्याणी येवले
 अध्याय 11:सौ सुनंदा सोनजे
अध्याय 12:सौ सरिता येवले
अध्याय 13:सौ सारिका येवले
 
* सर्व स्तोत्र,सिद्धकुञ्जिका स्तोत्र,देवीचा जयजयकार: सौ ज्योती पाख ले

*/
