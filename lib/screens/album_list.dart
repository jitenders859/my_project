import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upstreet_flutter_code_challenge/model/photos.dart';
import 'package:upstreet_flutter_code_challenge/providers/photosData.dart';
import 'package:upstreet_flutter_code_challenge/services/impl/app_response.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/route_paths.dart';
import 'package:upstreet_flutter_code_challenge/widgets/album_title.dart';

import '../services/api.dart';

// TODO:
// 1. Create a list view to display the album data from the fetching function in `api.dart`
// 2. The item of the list should contain the album's thumbnail and title

class AlbumList extends StatefulWidget {
  const AlbumList();

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getItems();
  }

  getItems() async {
    await Provider.of<PhotosData>(context, listen: false).getPhotos();
    // print('hello');
    List<Photos> photos =
        Provider.of<PhotosData>(context, listen: false).getAllPhotos();
    if (photos == null || photos.length == 0) {
      AppResponse<List<Photos>> response = await getPhotos();

      print('response');
      print(response.data);

      if (response.error == null) {
        for (int i = 0; i < response.data.length; i++) {
          print(response.data[i].title);
          Provider.of<PhotosData>(context, listen: false)
              .addPhoto(response.data[i]);
        }
        photos = response.data;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return AlbumTile(
                      tileIndex: index,
                    );
                  },
                  itemCount: Provider.of<PhotosData>(context).photoCount,
                  padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 4.0),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        tooltip: "Add",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, RoutePaths.AddAlbum);
        },
      ),
    );
  }
}
