import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cached_video_player_state.dart';

class CachedVideoPlayerCubit extends Cubit<CachedVideoPlayerState> {
  String videoUrl = "";
  String coverImg = "";
  CachedVideoPlayerCubit({required this.videoUrl, required this.coverImg})
      : super(CachedVideoPlayerInitial()) {
    videoUrl = videoUrl;
    coverImg = coverImg;
    _betterPlayerDataSource = BetterPlayerDataSource.file(File(videoUrl).path);
    betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
            autoDispose: true,
            autoPlay: true,
            placeholder: Image.network(
              coverImg,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Text("Video failed");
              },
            )),
        betterPlayerDataSource: _betterPlayerDataSource);
  }
  BetterPlayerDataSource? _betterPlayerDataSource;
  BetterPlayerController? betterPlayerController;
}
