import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;

  static Future init() async {
    pref = await SharedPreferences.getInstance();
  }

  int adhaypathno = 0;
  void setAdhaypathno(int no) {
    pref.setInt('adhaypathno', no);
  }

  int getAdhaypathno() {
    return pref.getInt('adhaypathno') ?? adhaypathno;
  }
}
