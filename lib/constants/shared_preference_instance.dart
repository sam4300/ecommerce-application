import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> preferenceInstance() async {
  return await SharedPreferences.getInstance();
}
