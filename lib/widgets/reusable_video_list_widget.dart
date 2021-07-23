// Project imports:
import 'package:alanis/export.dart';

class ReusableVideoListWidget extends StatefulWidget {
  final VideoListData videoListData;
  final ReusableVideoListController videoListController;
  final bool canBuildVideo;

  const ReusableVideoListWidget({
    Key key,
    this.videoListData,
    this.videoListController,
    this.canBuildVideo,
  }) : super(key: key);

  @override
  _ReusableVideoListWidgetState createState() =>
      _ReusableVideoListWidgetState();
}

class _ReusableVideoListWidgetState extends State<ReusableVideoListWidget> {
  VideoListData get videoListData => widget.videoListData;
  BetterPlayerController controller;
  StreamController<BetterPlayerController>
      betterPlayerControllerStreamController = StreamController.broadcast();
  bool _initialized = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    betterPlayerControllerStreamController.close();
    super.dispose();
  }

  void _setupController() {
    if (controller == null) {
      controller = widget.videoListController.getBetterPlayerController();
      if (controller != null) {
        controller.setupDataSource(
            BetterPlayerDataSource.network(videoListData.videoUrl,
                cacheConfiguration: BetterPlayerCacheConfiguration(
                  useCache: true,
                )));
        if (!betterPlayerControllerStreamController.isClosed) {
          betterPlayerControllerStreamController.add(controller);
        }
        controller.addEventsListener(onPlayerEvent);
      }
    }
  }

  void _freeController() {
    if (!_initialized) {
      _initialized = true;
      return;
    }
    if (controller != null && _initialized) {
      controller.removeEventsListener(onPlayerEvent);
      widget.videoListController.freeBetterPlayerController(controller);
      controller.pause();
      controller = null;
      if (!betterPlayerControllerStreamController.isClosed) {
        betterPlayerControllerStreamController.add(null);
      }
      _initialized = false;
    }
  }

  void onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      videoListData.lastPosition = event.parameters["progress"] as Duration;
    }
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (videoListData.lastPosition != null) {
        controller.seekTo(videoListData.lastPosition);
      }
      if (videoListData.wasPlaying) {
        controller.play();
      }
    }
  }

  ///TODO: Handle "setState() or markNeedsBuild() called during build." error
  ///when fast scrolling through the list
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VisibilityDetector(
          key: Key(hashCode.toString() + DateTime.now().toString()),
          onVisibilityChanged: (info) {
            if (!widget.canBuildVideo) {
              _timer?.cancel();
              _timer = null;
              _timer = Timer(Duration(milliseconds: 500), () {
                if (info.visibleFraction == 1.0) {
                  _setupController();
                } else {
                  _freeController();
                }
              });
              return;
            }
            if (info.visibleFraction == 1.0) {
              _setupController();
            } else {
              _freeController();
            }
          },
          child: StreamBuilder<BetterPlayerController>(
            stream: betterPlayerControllerStreamController.stream,
            builder: (context, snapshot) {
              return Container(
                height: 190,
                child: controller != null
                    ? BetterPlayer(
                        controller: controller,
                      )
                    : Container(
                        color: Colors.black,
                        child: Center(
                          child: Icon(
                            Icons.pause,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void deactivate() {
    if (controller != null) {
      videoListData.wasPlaying = controller.isPlaying();
    }
    _initialized = true;
    super.deactivate();
  }
}
