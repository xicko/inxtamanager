import 'package:flutter/material.dart';

class DownloadProgress extends StatelessWidget {
  final double progress;
  
  const DownloadProgress({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Theme.of(context).progressIndicatorTheme.linearTrackColor,
          minHeight: 28,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        const SizedBox(height: 4,),
        Text('${(progress * 100).toStringAsFixed(1)}% downloaded',
        style: TextStyle(
          fontFamily: 'InstagramSans'
        ),)
      ],
    );
  }
}