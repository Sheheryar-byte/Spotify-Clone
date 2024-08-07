import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:client/features/home/view/widgets/music_player.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);
    final userFavorites = ref.watch(currentUserNotifierProvider.select((data) => data!.favorites));

    if (currentSong == null) {
      return const SizedBox(height: 20);
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const MusicPlayer();
        }));
      },
      child: Stack(
        children: [
          Container(
            height: 66,
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
              color: hexToColor(currentSong.hex_code),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'music-image',
                      child: Container(
                        width: 48,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(currentSong.thumbnail_url),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentSong.song_name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          currentSong.artist,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Pallete.subtitleText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await ref.read(homeViewModelProvider.notifier).favSong(songId: currentSong.id);
                      },
                      icon:  Icon(
                        userFavorites.where((fav) => fav.song_id == currentSong.id).toList().isNotEmpty ? CupertinoIcons.heart_fill :
                        CupertinoIcons.heart),
                    ),
                    IconButton(
                      onPressed: songNotifier.playPause,
                      icon: Icon(
                        songNotifier.isPlaying ? CupertinoIcons.pause_fill : CupertinoIcons.play_fill),
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: songNotifier.audioPlayer?.positionStream,
            builder: (context, snapshot) {
      
              if(snapshot.connectionState == ConnectionState.waiting){
                return const SizedBox();
              }
              final position = snapshot.data;
              final duration = songNotifier.audioPlayer!.duration;
      
              double sliderValue = 0.0;
      
              if (position != null && duration!= null){
                sliderValue = position.inMilliseconds / duration.inMilliseconds ;
              }
      
              return Positioned(
                bottom: 0,
                left: 8, // or top, left, right depending on where you want to position it
                child: Container(
                  height: 2,
                  width: sliderValue * (MediaQuery.of(context).size.width - 32) ,
                  decoration:  BoxDecoration(
                    color: Pallete.gradient2,
                    borderRadius: BorderRadius.circular(7),
                  ), // Add a color if needed
                ),
              );
            }
          ),
      
          Positioned(
            bottom: 0,
            left: 8, // or top, left, right depending on where you want to position it
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width - 32,
              decoration:  BoxDecoration(
                color: Pallete.inactiveSeekColor,
                borderRadius: BorderRadius.circular(7),
              ), // Add a color if needed
            ),
          ),
        ],
      ),
    );
  }
}
