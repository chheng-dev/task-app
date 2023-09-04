import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_fire/constants/app_style.dart';
import 'package:todo_app_fire/model/todo_model.dart';
import 'package:todo_app_fire/provider/date_time_provider.dart';
import 'package:todo_app_fire/provider/radio_provider.dart';
import 'package:todo_app_fire/provider/service_provider.dart';

import '../widget/date_time_widget.dart';
import '../widget/radio_widget.dart';
import '../widget/text_field_widget.dart';

class AddNewTask extends ConsumerWidget {
  AddNewTask({
    Key? key,
  }) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datePro = ref.watch(dateProvider);
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10),
          SizedBox(
            width: double.infinity,
            child: Text(
              "New Task Todo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          Gap(12),
          Text(
            "Task title",
            style: AppStyle.headingOne,
          ),
          Gap(6),
          TextFieldWidget(
            hitText: "Add Task name.",
            maxLine: 1,
            txtController: titleController,
          ),
          Gap(12),
          Text(
            "Description",
            style: AppStyle.headingOne,
          ),
          Gap(6),
          TextFieldWidget(
            hitText: "Add Descriptions",
            maxLine: 5,
            txtController: descriptionController,
          ),
          Gap(12),
          Text(
            "Category",
            style: AppStyle.headingOne,
          ),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  titleRadio: "LNB",
                  catColor: Colors.green,
                  valueInput: 1,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 1),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: "WKR",
                  catColor: Colors.blue,
                  valueInput: 2,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 2),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: "GEN",
                  catColor: Colors.amberAccent.shade700,
                  valueInput: 3,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 3),
                ),
              ),
            ],
          ),
          Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                  titleText: "Date",
                  valueText: datePro,
                  icon: Icon(Icons.calendar_month),
                  onTap: () async {
                    final getValue = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2025));

                    if (getValue != null) {
                      final format = DateFormat.yMd();
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => format.format(getValue));
                    }
                  }),
              Gap(12),
              DateTimeWidget(
                titleText: "Time",
                valueText: ref.watch(timeProvider),
                icon: Icon(Icons.timer),
                onTap: () async {
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (getTime != null) {
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => getTime.format(context));
                  }
                },
              ),
            ],
          ),

          //Button Bottom
          Gap(10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Cancel'),
                ),
              ),
              Gap(20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    final getRadioValue = ref.read(radioProvider);
                    String category = '';

                    switch (getRadioValue) {
                      case 1:
                        category = "Learning";
                        break;
                      case 2:
                        category = "Working";
                        break;
                      case 3:
                        category = "General";
                        break;
                    }

                    ref.read(serviceProvider).addNewTask(
                          TodoModel(
                            titleTask: titleController.text,
                            description: descriptionController.text,
                            category: category,
                            date: ref.read(dateProvider),
                            time: ref.read(timeProvider),
                            isDone: false,
                          ),
                        );
                    print("Data has been saved !");
                    titleController.clear();
                    descriptionController.clear();
                    ref.read(radioProvider.notifier).update((state) => 0);
                    Navigator.pop(context);
                  },
                  child: Text('Create'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
