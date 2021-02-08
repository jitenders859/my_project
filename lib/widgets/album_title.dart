import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:upstreet_flutter_code_challenge/model/photos.dart';
import 'package:upstreet_flutter_code_challenge/providers/photosData.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/route_paths.dart';

class AlbumTile extends StatelessWidget {
  final int tileIndex;

  const AlbumTile({Key key, this.tileIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosData>(
      builder: (context, photosData, child) {
        Photos photo = photosData.getPhoto(tileIndex);

        return InkWell(
          onTap: () {
            Provider.of<PhotosData>(context, listen: false)
                .setActivePhoto(photo.key);

            Navigator.pushNamed(context, RoutePaths.AlbumView);
          },
          child: Row(
            children: [
              Container(
                height: 120.0,
                width: 120.0,
                padding: EdgeInsets.all(10.0),
                child: photo.thumbnailUrl != null
                    ? Image.network(photo.thumbnailUrl)
                    : Container(),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    photo?.title ?? "",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
