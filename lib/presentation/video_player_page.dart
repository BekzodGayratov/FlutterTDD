import 'dart:isolate';

import 'package:better_player/better_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/application/cubit/video_player_cubit_cubit.dart';
import 'package:tdd/application/service/video_downloader_service.dart';
import 'package:tdd/presentation/cached_video_player_screen.dart';

class VideoPlayerPage extends StatelessWidget {
  const VideoPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoPlayerCubit(
          videoUrl:
              "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
          coverImg: "https://www.filepicker.io/api/file/sXz6u6kMQzK9uXkCwtPv"),
      child: BlocBuilder<VideoPlayerCubit, VideoPlayerCubitState>(
          builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: MediaQuery.of(context).size.height * 0.5,
                title: const Text("Video player "),
                flexibleSpace: FlexibleSpaceBar(
                  background: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: state is VideoPlayerCubitLoading
                        ? Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://www.filepicker.io/api/file/sXz6u6kMQzK9uXkCwtPv"),
                                    fit: BoxFit.cover)),
                            child: const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          )
                        : BetterPlayer(
                            controller: context
                                .watch<VideoPlayerCubit>()
                                .betterPlayerController!),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              ReceivePort receivePort = ReceivePort();
              final isolate =
                  await Isolate.spawn(doSmthOnIsolate, receivePort.sendPort);
              final result = await receivePort.first;
              String videoPath = await result;
              isolate.kill();
              Future.delayed(Duration.zero).then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CachedVideoScreen(videoUrl: videoPath))));
            },
            child: const Text(""),
          ),
        );
      }),
    );
  }

  Future<void> doSmthOnIsolate(SendPort port) async {
    String path = await VideoDownloaderService().downloadVideo();
    port.send(path);
  }
}
