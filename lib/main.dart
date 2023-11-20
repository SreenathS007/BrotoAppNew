import 'package:brototype_app/custom_widgets/bottomNavbar.dart';
import 'package:brototype_app/database/functions/function/userFunctions/signup_function.dart';
import 'package:brototype_app/database/functions/models/adminmodel/register_model.dart';
import 'package:brototype_app/database/functions/models/adminmodel/video_add_model.dart';
import 'package:brototype_app/database/functions/models/signup_model.dart';
import 'package:brototype_app/database/functions/models/usermodels/notes_model.dart';
import 'package:brototype_app/firebase_options.dart';
import 'package:brototype_app/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const savekeyName = 'UserLoggedIn';
const emailkeyName = 'userEmailKey';
ValueNotifier<String> imgPath = ValueNotifier('');
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  // final Box<NoteModel> notesBox = await Hive.openBox<NoteModel>('notes');
  //student register Adapterer an adapter?)
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  //video adding adapter
  if (!Hive.isAdapterRegistered(VideoModelAdapter().typeId)) {
    Hive.registerAdapter(VideoModelAdapter());
  }

  //studentNotes adapter
  if (!Hive.isAdapterRegistered(NoteModelAdapter().typeId)) {
    Hive.registerAdapter(NoteModelAdapter());
  }
  //signup user model adapter
  if (!Hive.isAdapterRegistered(UserdataModalAdapter().typeId)) {
    Hive.registerAdapter(UserdataModalAdapter());
  }
//studentnotes box opened here0
  Box<NoteModel> _notesBox = await Hive.openBox<NoteModel>('notes');

  await getUserImg();
  HiveDb db = HiveDb();

  Box userBox = await Hive.openBox(db.userBoxKey);

  final sharedPrefs = await SharedPreferences.getInstance();

  String? email = sharedPrefs.getString(emailkeyName);
  UserdataModal? user;
  if (email != null) {
    user = userBox.get(email);
  }

  if (user != null) {
    user_name = user.username;
    user_email = user.email;
    user_password = user.phone;
  } else {
    // Handle the null or non-existent user case appropriately
    // For example, you can assign default values or handle the situation in a way that is suitable for your application logic.
    user_name = 'Default Username';
    user_email = 'Default Email';
    user_password = 'Default Password';
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
    );
  }
}
