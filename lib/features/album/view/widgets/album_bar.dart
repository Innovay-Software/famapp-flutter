import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/buttons/background_button.dart';
import '../../../../core/widgets/expanded_text.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/album.dart';
import '../../viewmodel/album_viewmodel.dart';
import '../album_settings_page.dart';

class AlbumBar extends StatefulWidget {
  final Album album;
  final double paddingLeft;

  const AlbumBar({
    super.key,
    required this.album,
    this.paddingLeft = 15,
  });

  @override
  State<AlbumBar> createState() => _AlbumBarState();
}

class _AlbumBarState extends State<AlbumBar> {
  final AlbumViewmodel _albumViewmodel = AlbumViewmodel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Album>(
      builder: (context, candidateItems, rejectedItems) {
        return Column(children: [
          GestureDetector(
            onTap: () {
              _onEditFolderTap(widget.album);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: InnoConfig.colors.backgroundColor,
                  border: Border(bottom: BorderSide(color: InnoConfig.colors.dividerLineColor))),
              padding: EdgeInsets.only(left: widget.paddingLeft, right: 15, top: 15, bottom: 15),
              child: Row(children: [
                if (widget.paddingLeft > 15) const Icon(CupertinoIcons.arrow_turn_down_right, size: 14),
                ExpandedText(widget.album.title),
                Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InnovayBackgroundButton(
                      '',
                      InnoConfig.colors.textColor,
                      () {
                        if (widget.paddingLeft > 15) {
                          _moveFolderToTop(widget.album);
                        }
                      },
                      prefixWidget: Icon(Icons.vertical_align_top, color: InnoConfig.colors.primaryColorLighter),
                      fontSize: 0,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Draggable<Album>(
                    data: widget.album,
                    feedback: Transform.translate(
                      offset: const Offset(-50, 0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 0),
                        child: InnoText(
                          widget.album.title,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    child: Icon(CupertinoIcons.move, size: 18, color: InnoConfig.colors.primaryColorLighter),
                  ),
                ),
              ]),
            ),
          ),
          Column(
            children: widget.album.subAlbums.map((item) {
              return Builder(builder: (BuildContext context) {
                return AlbumBar(
                  album: item,
                  paddingLeft: widget.paddingLeft + 15,
                );
              });
            }).toList(),
          )
        ]);
      },
      onAccept: (item) {
        if (item.id == widget.album.id) {
          return;
        }
        _albumViewmodel.setAlbumNewParent(item, widget.album);
      },
    );
  }

  void _onEditFolderTap(Album folder) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlbumSettingsPage(album: folder)),
    );
  }

  void _moveFolderToTop(Album album) {
    if (album.parent == null) {
      _albumViewmodel.albums.remove(album);
    } else {
      album.parent!.subAlbums.remove(album);
      album.parent = null;
      album.parentId = 0;
      _albumViewmodel.albums.add(album);
    }
    _albumViewmodel.saveAlbum(album);
  }
}
