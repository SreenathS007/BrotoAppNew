import 'package:brototype_app/database/functions/models/signup_model.dart';
import 'package:brototype_app/main.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveDb {
  String userBoxKey = 'USERBOX';

  void addUser(UserdataModal value) async {
    Box userDb = await Hive.openBox<UserdataModal>(userBoxKey);
  }
}

getUserImg() async {
  print("Calling getuserimage///////");
  HiveDb db = HiveDb();
  final sharedPrefs = await SharedPreferences.getInstance();
  Box userBox = await Hive.openBox(db.userBoxKey);
  String? email = sharedPrefs.getString(emailkeyName);

  if (email != null) {
    print("email Not null//////");
    UserdataModal? user = await userBox.get(email);
    if (user != null) {
      print("user Not Null//////");

      imgPath.value = user.imgPath ?? '';
      imgPath.notifyListeners();
      print('printing user image path ${user.imgPath}');
    }
  }
}
