import 'package:ads_code_library_issue/providers/sharedPref.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Products with ChangeNotifier {
  SharedPreferences? prefs;
  int? launchCount;
  int? finalCount;
  int whichPathIndex = 2;
  int purushIndex = 0;
  int mahilaIndex = 0;
  bool adhaypathnosignisPlus = true;
  int adhaypathno = 0;
  initialiseSharedPreferences() {
    prefs = SharedPref.pref;
  }

  void setPurushIndexFun(int i) {
    SharedPref.pref.setInt("purushIndex", i);
  }

  int getPurushIndexFun() {
    return SharedPref.pref.getInt('purushIndex') ?? 0;
    return 0;
  }

  void setMahilaIndexFun(int i) async {
    SharedPref.pref.setInt("mahilaIndex", i);
  }

  int getMahilaIndexFun() {
    return SharedPref.pref.getInt('mahilaIndex') ?? 0;
    return 0;
  }

  void setPathIndex(int i) async {
    SharedPref.pref.setInt("pathIndex", i);
    //  return 0;
  }

  int getPathIndex() {
    return SharedPref.pref.getInt("pathIndex") ?? 2;
    return 0;
  }

  void increamentFinalCount() {
    int finalCount = SharedPref.pref.getInt("finalCount") ?? 0;
    SharedPref.pref.setInt("finalCount", finalCount + 1);
  }

  void incrementLaunchCount() async {
    launchCount = SharedPref.pref.getInt("launchCount") ?? 0;

    SharedPref.pref.setInt("launchCount", launchCount! + 1);
  }

  int getFinalCount() {
    //  notifyListeners();
    return SharedPref.pref.getInt("finalCount") ?? 1;
    return 0;
  }

  int getLaunchCount() {
    //  notifyListeners();
    return SharedPref.pref.getInt("launchCount") ?? 1;
    return 0;
  }

  void setAdhaypathno(int no) {
    adhaypathno = getAdhaypathnosignisPlusOrNot() ? no : no * (-1);
    SharedPref.pref.setInt('adhaypathno', no);
    notifyListeners();
  }

  int getAdhaypathno() {
    return SharedPref.pref.getInt('adhaypathno') ?? adhaypathno;
  }

  void setAdhaypathnoSign(bool adhaypathnosign) {
    SharedPref.pref.setBool('adhaypathnosignisPlus', adhaypathnosign);
    adhaypathnosignisPlus = SharedPref.pref.getBool('adhaypathnosignisPlus') ??
        adhaypathnosignisPlus;

    setAdhaypathno(getAdhaypathno());

    notifyListeners();
  }

  bool getAdhaypathnosignisPlusOrNot() {
    return SharedPref.pref.getBool('adhaypathnosignisPlus') ??
        adhaypathnosignisPlus;
  }
}
