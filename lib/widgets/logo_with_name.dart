import 'package:flutter/material.dart';
import 'package:inxtamanager/theme/colors.dart';

class LogoWithName extends StatelessWidget {
  const LogoWithName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          // logo
          image: AssetImage('assets/logo512.png'),
          width: 100,
          height: 100,
        ),
        Text(
          // title
          'Inxta Manager',
          style: TextStyle(
            fontFamily: 'InstagramSansHeadline',
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: AppColors.titleTextColor(Theme.of(context).brightness),
          ),
        ),
      ],
    );
  }
}
