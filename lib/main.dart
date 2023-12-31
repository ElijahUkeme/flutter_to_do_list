import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/database/database_helper.dart';
import 'package:flutter_to_do_list/model/TaskModel.dart';
import 'package:flutter_to_do_list/pages/home_page.dart';
import 'package:flutter_to_do_list/services/theme_services.dart';
import 'package:flutter_to_do_list/utils/themes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DatabaseHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home:HomePage()
    );
  }

}

