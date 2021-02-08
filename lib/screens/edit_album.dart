import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upstreet_flutter_code_challenge/model/photos.dart';
import 'package:upstreet_flutter_code_challenge/providers/photosData.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/toast_widget.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/util.dart';
//import 'package:intl/intl.dart';

class AlbumEditPage extends StatefulWidget {
  final Photos currentPhoto;

  const AlbumEditPage({this.currentPhoto});

  @override
  _AlbumEditPageState createState() => _AlbumEditPageState();
}

class _AlbumEditPageState extends State<AlbumEditPage> {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  void _editPhoto(context) {
    if (title == null || title == "") {
      toastWidget("Title Can't be empty");
      return;
    }
    if (url == null || url.length < 2) {
      toastWidget("Image Url can' be empty");
      return;
    }

    if (widget.currentPhoto != null) {
      Provider.of<PhotosData>(context, listen: false).editPhoto(
        photo: Photos(
          albumId: albumId,
          id: id,
          title: title,
          url: url,
          thumbnailUrl: thumbnailUrl,
        ),
        photoKey: widget.currentPhoto.key,
      );
      Navigator.pop(context);
    } else {
      Provider.of<PhotosData>(context, listen: false).addPhoto(
        Photos(
          albumId: albumId,
          id: id,
          title: title,
          url: url,
          thumbnailUrl: thumbnailUrl,
        ),
      );
      Navigator.pop(context);
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    if (widget.currentPhoto != null) {
      //Set the initial text field value and state value for the current Photo
      _titleController.text = widget.currentPhoto?.title;
      title = widget.currentPhoto?.title;

      _urlController.text = widget.currentPhoto?.url.toString();
      url = widget.currentPhoto?.url.toString();
      thumbnailUrl = widget.currentPhoto?.url.toString();
      id = widget.currentPhoto?.id;
      albumId = widget.currentPhoto?.albumId;
    } else {
      getTheLastItem();
    }
    super.initState();
  }

  getTheLastItem() async {
    albumId = 1;
    await Provider.of<PhotosData>(context, listen: false).getPhotos();
    // print('hello');
    List<Photos> photos =
        Provider.of<PhotosData>(context, listen: false).getAllPhotos();
    if (photos != null) {
      id = photos.last.key + 1;
    } else {
      id = 1;
    }
  }

  Widget build(BuildContext context) {
    if (widget.currentPhoto == null) {
      if (widget.currentPhoto == null) {}
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 16.0,
        title: Text(
          widget.currentPhoto != null
              ? "Edit ${widget.currentPhoto.title}"
              : "Add Album",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                autofocus: true,
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                ),
                onChanged: (v) {
                  setState(
                    () {
                      title = v;
                    },
                  );
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                autofocus: true,
                controller: _urlController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: "Url"),
                onChanged: (v) {
                  setState(
                    () {
                      url = v;
                      thumbnailUrl = v;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key("1"),
        tooltip: "Save",
        child: Icon(Icons.check, color: Colors.white),
        onPressed: () {
          Log.d("Selcted to Save");
          _editPhoto(context);
        },
      ),
    );
  }
}
