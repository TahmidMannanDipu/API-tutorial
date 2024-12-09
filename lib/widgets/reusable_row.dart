import 'package:flutter/material.dart';

import '../const.dart';

class ResUsableRow extends StatelessWidget {
  final String title, value;
  const ResUsableRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.titleStyle,
        ),
        Text(
          value,
          style: AppTextStyle.bodyStyle,
        )
      ],
    );
  }
}