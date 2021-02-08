import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upstreet_flutter_code_challenge/screens/album_view.dart';
import 'package:upstreet_flutter_code_challenge/screens/edit_album.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/route_paths.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/util.dart';

import '../screens/album_list.dart';

class Routes {
  static Future _initHive() async {
    // final Permission _permissionHandler = Permissionh()
    Permission.storage.request().then((value) async {
      if (value == PermissionStatus.granted) {
        var dir = await getApplicationDocumentsDirectory();
        Hive.init(dir.path);
      } else {
        Log.i("permission denied");
      }
    });
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.AlbumList:
        return MaterialPageRoute(
          builder: (_) => FutureBuilder(
            future: _initHive(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  print(snapshot.error);
                  return Scaffold(
                    body: Center(
                      child: Text('Error Initializing hive data store'),
                    ),
                  );
                } else {
                  return AlbumList();
                }
              } else
                return Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
            },
          ),
        );
      case RoutePaths.AddAlbum:
        return MaterialPageRoute(builder: (_) => AlbumEditPage());
      case RoutePaths.AlbumView:
        return MaterialPageRoute(builder: (_) => AlbumView());
      case RoutePaths.EditAlbum:
        return MaterialPageRoute(
            builder: (_) => AlbumEditPage(
                  currentPhoto: settings.arguments,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No Route Defined with name ${settings.name}')),
          ),
        );
    }
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}
