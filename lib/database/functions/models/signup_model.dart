import 'package:hive/hive.dart';
part 'signup_model.g.dart';

@HiveType(typeId: 3)
class UserdataModal {
  @HiveField(0)
  String username;
  @HiveField(1)
  String email;
  @HiveField(2)
  String phone;
  @HiveField(3)
  String cnfmpassword;
  @HiveField(4)
  String? imgPath = 'assets/images/stdprofile.png';
  UserdataModal({
    required this.username,
    required this.email,
    required this.phone,
    required this.cnfmpassword,
    this.imgPath,
  });
}
