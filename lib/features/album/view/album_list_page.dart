import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/config.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/no_content_placeholder_widget.dart';
import '../model/album.dart';
import '../viewmodel/album_viewmodel.dart';
import 'album_settings_page.dart';
import 'widgets/album_bar.dart';

class AlbumListPage extends StatefulWidget {
  const AlbumListPage({super.key});

  @override
  State<AlbumListPage> createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    var albums = context.watch<AlbumViewmodel>().albums;
    return Scaffold(
      appBar: InnoAppBar(
        false,
        'Albums',
        [IconButton(onPressed: _onCreateAlbumTap, icon: const Icon(CupertinoIcons.add))],
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        color: InnoConfig.colors.backgroundColorTinted3,
        child: Column(
          children: albums.isEmpty
              ? [
                  const Row(mainAxisAlignment: MainAxisAlignment.center, children: [InnoNoContentPlaceholder()])
                ]
              : albums.map((item) {
                  return Builder(builder: (BuildContext context) {
                    return AlbumBar(album: item);
                  });
                }).toList(),
        ),
      ),
    );
  }

  void _onCreateAlbumTap() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlbumSettingsPage(album: Album.createEmptyAlbum())),
    );
  }
}
