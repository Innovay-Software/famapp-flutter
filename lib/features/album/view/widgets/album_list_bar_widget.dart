import 'package:flutter/material.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../viewmodel/album_viewmodel.dart';

class AlbumListBar extends StatefulWidget {
  final double albumCoverSize;
  final double height;
  final double paddingTop;
  final Function(int) onAlbumTap;
  final ScrollController? scrollController;

  const AlbumListBar({
    super.key,
    required this.onAlbumTap,
    this.paddingTop = 20,
    this.albumCoverSize = 46.0,
    this.height = 100,
    this.scrollController,
  });

  @override
  State<StatefulWidget> createState() => _AlbumListBarState();
}

class _AlbumListBarState extends State<AlbumListBar> {
  final AlbumViewmodel _albumViewmodel = AlbumViewmodel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var folderModels = _albumViewmodel.albums;
    var folderIconHorizontalPadding = (MediaQuery.of(context).size.width - 40 * 2 - widget.albumCoverSize * 4) / 4 / 2;
    var folderBarRowPadding = folderModels.length <= 3 ? 26.0 : 40.0;
    if (folderModels.length <= 3) {
      folderIconHorizontalPadding = 0;
    }
    var folderWidgets = folderModels.map((folder) {
      final isSelected = _albumViewmodel.currentAlbum != null && _albumViewmodel.currentAlbum!.id == folder.id;
      return GestureDetector(
        onTap: () {
          widget.onAlbumTap(folder.id);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                color: isSelected ? InnoConfig.colors.primaryColorLighter : InnoConfig.colors.backgroundColor,
                width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: InnovayCachedImage(
              folder.cover,
              width: widget.albumCoverSize - 4,
              height: widget.albumCoverSize - 4,
              placeholderWidget: Container(
                color: InnoConfig.colors.primaryColor,
                width: widget.albumCoverSize - 6,
                height: widget.albumCoverSize - 4,
                child: Center(
                  child: InnoText(
                    folder.title.isEmpty ? '' : folder.title[0],
                    color: InnoConfig.colors.primaryColorTextColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();

    folderWidgets.add(GestureDetector(
      onTap: () {
        widget.onAlbumTap(0);
      },
      child: Container(
        width: widget.albumCoverSize,
        height: widget.albumCoverSize,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
        child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => InnoConfig.linearGradient.createShader(bounds),
            child: const Icon(Icons.create_new_folder, size: 24, color: Colors.white)),
      ),
    ));

    var rowWidget = Row(
      mainAxisAlignment: folderModels.length <= 3 ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: folderWidgets
          .map(
            (e) => Padding(
              padding: EdgeInsets.symmetric(horizontal: folderIconHorizontalPadding),
              child: e,
            ),
          )
          .toList(),
    );

    return Container(
      height: widget.height,
      padding: EdgeInsets.only(left: folderBarRowPadding, right: folderBarRowPadding, top: widget.paddingTop),
      decoration: BoxDecoration(
        color: InnoConfig.colors.backgroundColorTinted3,
      ),
      child: folderModels.length <= 3
          ? rowWidget
          : SingleChildScrollView(
              controller: widget.scrollController,
              scrollDirection: Axis.horizontal,
              child: rowWidget,
            ),
    );
  }
}
