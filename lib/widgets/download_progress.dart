import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inxtamanager/controllers/download_controller.dart';

class DownloadProgress extends StatefulWidget {
  const DownloadProgress({
    super.key,
  });

  @override
  State<DownloadProgress> createState() => _DownloadProgressState();
}

class _DownloadProgressState extends State<DownloadProgress>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.easeInOutQuad,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // isDownloading Listener
    ever(DownloadController.to.isDownloading, (isDownloading) {
      if (isDownloading) {
        // Play anim
        controller.forward();
      } else {
        // Reverse anim
        controller.reverse();
      }
    });

    return Obx(
      () => SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        axisAlignment: -1,
        child: AnimatedOpacity(
          opacity: DownloadController.to.isDownloading.value ? 1 : 0,
          duration: Duration(milliseconds: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: DownloadController.to.downloadProgress.value,
                backgroundColor:
                    Theme.of(context).progressIndicatorTheme.linearTrackColor,
                minHeight: 28,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '${(DownloadController.to.downloadProgress.value * 100).toStringAsFixed(1)}% downloaded',
                style: TextStyle(fontFamily: 'InstagramSans'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
