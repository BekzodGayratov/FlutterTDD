import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/application/cubit/cached_video_player_cubit.dart';
import 'package:tdd/application/service/video_downloader_service.dart';

class CachedVideoScreen extends StatelessWidget {
  final String videoUrl;
  const CachedVideoScreen({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CachedVideoPlayerCubit(
          videoUrl: videoUrl,
          coverImg: "https://www.filepicker.io/api/file/sXz6u6kMQzK9uXkCwtPv"),
      child: BlocBuilder<CachedVideoPlayerCubit, CachedVideoPlayerState>(
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
                    child: state is CachedVideoPlayerLoading
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
                                .watch<CachedVideoPlayerCubit>()
                                .betterPlayerController!),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              VideoDownloaderService().downloadVideo();
            },
            child: const Text(""),
          ),
        );
      }),
    );
  }
}
