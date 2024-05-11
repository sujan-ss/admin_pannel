import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerDialog {
  void showAudioPlayer({
    required BuildContext context,
    required String audioUrl,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AudioPlayerWidget(
          audioUrl:
              "https://soundcloud.com/harris-ford-official/ein-kompliment?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing",
        );
      },
    );
  }
}

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key, required this.audioUrl});
  final String audioUrl;

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late final AudioPlayer audioPlayer;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool isPlaying = false;
  @override
  void initState() {
    audioPlayer = AudioPlayer();
    super.initState();
  }

  Future<void> playPauseAudio() async {
    if (isPlaying) {
      isPlaying = !isPlaying;
      return audioPlayer.pause();
    } else {
      isPlaying = !isPlaying;
      return audioPlayer.play(UrlSource(widget.audioUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) {}),
          Row(
            children: [Text(position.toString()), Text(duration.toString())],
          ),
          Center(
            child: CircleAvatar(
              child: GestureDetector(
                onTap: () async {
                  playPauseAudio();
                },
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
