import 'package:better_player/better_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'video_player_cubit_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerCubitState> {
  String videoUrl = "";
  String coverImg = "";
  VideoPlayerCubit({required this.videoUrl, required this.coverImg})
      : super(VideoPlayerCubitInitial()) {
    videoUrl = videoUrl;
    coverImg = coverImg;
    _betterPlayerDataSource = BetterPlayerDataSource.network(
        videoUrl);
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
