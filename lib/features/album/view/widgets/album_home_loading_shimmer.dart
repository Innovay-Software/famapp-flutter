import 'dart:ui';

import 'package:famapp/core/utils/dot_env_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/config.dart';
import 'album_home_album_section_top_border.dart';
import 'album_home_app_bar.dart';

class AlbumHomeLoadingShimmer extends StatelessWidget {
  const AlbumHomeLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: Stack(children: [
        Image.asset(
          'assets/aurora/aurora_g1.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 55.0,
            sigmaY: 55.0,
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 350),
          child: Container(
            color: InnoConfig.colors.backgroundColorTinted3,
            width: MediaQuery.of(context).size.width,
            height: 300,
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // Row(),
          AlbumHomeAppBar(
            height: 35,
            title: DotEnvField.APP_NAME.getDotEnvString(''),
            onActionButtonTap: (index) {},
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 40),
                Shimmer.fromColors(
                  baseColor: const Color(0x55EBEBF4),
                  highlightColor: const Color(0x99F4F4F4),
                  child: Container(color: Colors.white, width: 150, height: 30),
                ),
                const SizedBox(height: 20),
                Shimmer.fromColors(
                  baseColor: const Color(0x55EBEBF4),
                  highlightColor: const Color(0x99F4F4F4),
                  child: Container(color: Colors.white, width: 220, height: 20),
                ),
                const SizedBox(height: 40),
                Stack(children: [
                  const Padding(padding: EdgeInsets.only(top: 90), child: AlbumHomeAlbumSectionTopBorder(height: 80)),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100), border: Border.all(width: 4, color: Colors.white)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/ui/Logo128.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: 130,
                            height: 130),
                      ),
                    ),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Shimmer.fromColors(
                          baseColor: const Color(0xFFDEDEF4),
                          highlightColor: const Color(0xFFF4F4F4),
                          child: Container(color: Colors.white, width: 40, height: 40),
                        )),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Shimmer.fromColors(
                          baseColor: const Color(0xFFDEDEF4),
                          highlightColor: const Color(0x99F4F4F4),
                          child: Container(color: Colors.white, width: 40, height: 40),
                        )),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Shimmer.fromColors(
                          baseColor: const Color(0xFFDEDEF4),
                          highlightColor: const Color(0x99F4F4F4),
                          child: Container(color: Colors.white, width: 40, height: 40),
                        )),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Shimmer.fromColors(
                        baseColor: const Color(0xFFDEDEF4),
                        highlightColor: const Color(0x99F4F4F4),
                        child: Container(color: Colors.white, width: 40, height: 40),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 300,
                  child: GridView.count(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(6, (index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Shimmer.fromColors(
                          baseColor: const Color(0xFFDEDEF4),
                          highlightColor: const Color(0x99F4F4F4),
                          child: Container(color: Colors.white, width: 40, height: 40),
                        ),
                      );
                    }),
                  ),
                ),
              ]),
            ),
          ),
        ])
      ]),
    );
  }
}
