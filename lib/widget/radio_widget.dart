import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_fire/provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget({
    Key? key,
    required this.titleRadio,
    required this.catColor,
    required this.valueInput,
    required this.onChangeValue,
  }) : super(key: key);

  final String titleRadio;
  final Color catColor;
  final int valueInput;
  final VoidCallback onChangeValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioCategory = ref.watch(radioProvider);
    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: catColor),
        child: RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
            offset: Offset(-22, 0),
            child: Text(
              titleRadio,
              style: TextStyle(
                color: catColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          value: valueInput,
          groupValue: radioCategory,
          onChanged: (value) => onChangeValue(),
        ),
      ),
    );
  }
}
