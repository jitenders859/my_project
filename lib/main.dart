import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:upstreet_flutter_code_challenge/model/photos.dart';
import 'package:upstreet_flutter_code_challenge/providers/itemData.dart';
import 'package:upstreet_flutter_code_challenge/providers/photosData.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/route_paths.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/routes.dart';

import './screens/album_list.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Hive.registerAdapter(PhotosAdapter());
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Future _initHive() async {
    // final Permission _permissionHandler = Permissionh()
    Permission.storage.request().then((value) async {
      if (value == PermissionStatus.granted) {
        var dir = await getApplicationDocumentsDirectory();
        Hive.init(dir.path);
      } else {
        print("permission denied");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PhotosData(),
        ),
      ],
      child: MaterialApp(
        title: 'Upstreet Flutter code challenge',
        theme: ThemeData(
          primaryColor: const Color(0xff01046d),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: Routes.generateRoute,
        initialRoute: RoutePaths.AlbumList,
      ),
    );
  }
}
