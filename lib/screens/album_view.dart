import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upstreet_flutter_code_challenge/model/photos.dart';
import 'package:upstreet_flutter_code_challenge/providers/photosData.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/route_paths.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/util.dart';

class AlbumView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _deleteConfirmation(currentPhoto) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Are you sure?",
              style: TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You are about to delete ${currentPhoto.name}'),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("This action cannot be undone")
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "DELETE",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Log.d("Deleting ${currentPhoto.name}");
                  Provider.of<PhotosData>(context, listen: false)
                      .deletePhoto(currentPhoto.key);

                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(Navigator.defaultRouteName),
                  );
                },
              ),
              FlatButton(
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Log.d('Cancelling');
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }

    return Consumer<PhotosData>(builder: (context, photoData, child) {
      Photos currentPhoto = photoData.getActivePhoto();

      return Scaffold(
        appBar: AppBar(
          elevation: 16.0,
          title: Text(
            currentPhoto?.title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: 150.0,
                  padding: EdgeInsets.only(top: 50.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(currentPhoto.thumbnailUrl),
                          fit: BoxFit.cover)),
                ),
                SizedBox(height: 50.0),
                Text(
                  currentPhoto?.title.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: Key("1"),
          tooltip: "Edit",
          child: Icon(Icons.edit, color: Colors.white),
          onPressed: () {
            Log.d("Selcted to edit");
            Navigator.pushNamed(context, RoutePaths.EditAlbum,
                arguments: currentPhoto);
          },
        ),
        // FloatingActionButton(
        //   key: Key("2"),
        //   backgroundColor: Colors.greenAccent,
        //   tooltip: "Delete",
        //   child: Icon(Icons.delete, color: Colors.white),
        //   onPressed: () {
        //     Log.d("Selected to delete");
        //     _deleteConfirmation(currentPhoto);
        //   },
        // ),
        //   ],
        // ),
      );
    });
  }
}
