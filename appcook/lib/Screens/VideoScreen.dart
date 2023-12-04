import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;

  VideoScreen({required this.videoUrl});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // Tạo VideoPlayerController từ URL video
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);

    // Tạo ChewieController
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9, // Tỷ lệ khung hình video
      autoPlay: true, // Tự động phát video khi màn hình được mở
      looping: false, // Lặp video hay không
    );
  }

  @override
  void dispose() {
    // Hủy bỏ các controllers khi widget bị hủy
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem Video'),
      ),
      body: Center(
        child: Chewie(controller: _chewieController),
      ),
    );
  }
}
