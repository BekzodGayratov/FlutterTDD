part of 'cached_video_player_cubit.dart';

sealed class CachedVideoPlayerState extends Equatable {
  const CachedVideoPlayerState();

  @override
  List<Object> get props => [];
}

final class CachedVideoPlayerInitial extends CachedVideoPlayerState {}

final class CachedVideoPlayerLoading extends CachedVideoPlayerState {}

final class CachedVideoPlayerComplete extends CachedVideoPlayerState {}

final class CachedVideoPlayerError extends CachedVideoPlayerState {}
