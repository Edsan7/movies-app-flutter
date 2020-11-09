import 'package:ext_video_player/ext_video_player.dart';
import 'package:flutter/material.dart';
import 'package:movies/widgets/video/play_pause_overlay.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String url;
  final String title;

  const CustomVideoPlayer({
    @required this.url,
    this.title = '',
  });

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController _videoPlayerController;

  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  _initializeVideo() {
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _videoPlayerController.addListener(() {
      setState(() {});
    });
    _videoPlayerController.setLooping(true);
    _videoPlayerController.initialize();
    _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Text(widget.title, style: TextStyle(fontSize: 20))),
        Container(
          padding: const EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_videoPlayerController),
                ClosedCaption(text: _videoPlayerController.value.caption.text),
                PlayPauseOverlay(controller: _videoPlayerController),
                VideoProgressIndicator(
                  _videoPlayerController,
                  allowScrubbing: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
