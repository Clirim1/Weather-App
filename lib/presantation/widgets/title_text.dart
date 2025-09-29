import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final bool isSubtitle;
  const TitleText({super.key, required this.title, this.isSubtitle = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: isSubtitle ? 16 : 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
