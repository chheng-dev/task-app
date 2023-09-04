import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_fire/constants/app_style.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    Key? key,
    required this.titleText,
    required this.valueText,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String titleText;
  final String valueText;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: AppStyle.headingOne,
            ),
            Gap(6),
            Material(
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => onTap(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        icon,
                        Gap(6),
                        Text(valueText),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
