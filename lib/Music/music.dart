import 'package:boosic/Get/MusicLinkController.dart';
import 'package:boosic/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.stop();

    // Set a sequence of audio sources that will be played by the audio player.
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget _playPauseButton(PlayerState? playerState) {
    if (playerState == null) {
      return Container(); // You might want to return some default widget or handle this case differently
    }

    final processingState = playerState.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: EdgeInsets.all(8.0),
        width: 64.0,
        height: 64.0,
        child: CircularProgressIndicator(),
      );
    } else if (_audioPlayer.playing != true) {
      return IconButton(
        icon: Icon(Icons.play_arrow),
        iconSize: 64.0,
        onPressed: _audioPlayer.play,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        icon: Icon(Icons.pause),
        iconSize: 64.0,
        onPressed: _audioPlayer.pause,
      );
    } else {
      return IconButton(
        icon: Icon(Icons.replay),
        iconSize: 64.0,
        onPressed: () => _audioPlayer.seek(Duration.zero,
            index: _audioPlayer.effectiveIndices?.first),
      );
    }
  }

  Widget _shuffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      icon: isEnabled
          ? Icon(Icons.shuffle, color: Colors.grey)
          : Icon(Icons.shuffle),
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await _audioPlayer.shuffle();
        }
        await _audioPlayer.setShuffleModeEnabled(enable);
      },
    );
  }

  Widget _previousButton() {
    return IconButton(
      icon: Icon(Icons.skip_previous),
      onPressed: _audioPlayer.hasPrevious ? _audioPlayer.seekToPrevious : null,
    );
  }

  Widget _nextButton() {
    return IconButton(
      icon: Icon(Icons.skip_next),
      onPressed: _audioPlayer.hasNext ? _audioPlayer.seekToNext : null,
    );
  }

  Widget _repeatButton(BuildContext context, LoopMode loopMode) {
    final icons = [
      Icon(Icons.repeat),
      Icon(Icons.repeat, color: Colors.grey),
      Icon(Icons.repeat_one, color: Colors.grey),
    ];
    const cycleModes = [
      LoopMode.off,
      LoopMode.all,
      LoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
      icon: icons[index],
      onPressed: () {
        _audioPlayer.setLoopMode(
            cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicLinkController>(
      builder: (controller) {
        _audioPlayer
            .setAudioSource(ConcatenatingAudioSource(
                children: controller.audio_list.toList()))
            // ignore: body_might_complete_normally_catch_error
            .catchError((error) {
          // catch load errors: 404, invalid url ...
        });

        return Stack(alignment: Alignment.bottomCenter, children: [
          StreamBuilder(
            stream: _audioPlayer.currentIndexStream,
            builder: (_, snapshot) {
              if (snapshot.data != null) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        height: 70,
                        color:
                            index == snapshot.data ? Colors.grey : Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text("Music #$index",
                                    style: TextStructure.header)
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                controller.deleteAudioElem(index);
                                _audioPlayer.stop();
                                _audioPlayer = AudioPlayer();
                                _audioPlayer
                                    .setAudioSource(ConcatenatingAudioSource(
                                        children:
                                            controller.audio_list.toList()))
                                    // ignore: body_might_complete_normally_catch_error
                                    .catchError((error) {
                                  // catch load errors: 404, invalid url ...
                                  SystemNavigator.pop();
                                });
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: controller.audio_list.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          Transform.translate(
            offset: Offset(0, -25),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder<bool>(
                  stream: _audioPlayer.shuffleModeEnabledStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return _shuffleButton(context, snapshot.data ?? false);
                    else
                      return Container();
                  },
                ),
                StreamBuilder<SequenceState?>(
                  stream: _audioPlayer.sequenceStateStream,
                  builder: (_, __) {
                    if (__.hasData)
                      return _previousButton();
                    else
                      return Container();
                  },
                ),
                StreamBuilder<PlayerState>(
                  stream: _audioPlayer.playerStateStream,
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      final playerState = snapshot.data;
                      return _playPauseButton(playerState!);
                    } else
                      return Container();
                  },
                ),
                StreamBuilder<SequenceState?>(
                  stream: _audioPlayer.sequenceStateStream,
                  builder: (_, __) {
                    if (__.hasData)
                      return _nextButton();
                    else
                      return Container();
                  },
                ),
                StreamBuilder<LoopMode>(
                  stream: _audioPlayer.loopModeStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return _repeatButton(
                          context, snapshot.data ?? LoopMode.off);
                    else
                      return Container();
                  },
                ),
              ],
            ),
          ),
        ]);
      },
    );
  }
}
