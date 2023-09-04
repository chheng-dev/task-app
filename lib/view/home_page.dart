import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_fire/common/show_model.dart';
import 'package:todo_app_fire/provider/service_provider.dart';
import 'package:todo_app_fire/widget/card_todo_widget.dart';

class Homepage extends ConsumerWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchSteamProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 25,
            // child: Image.asset('assets/images/avatar.jpg'),
          ),
          title: Text(
            "Hello",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          subtitle: Text(
            "Chheng",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                Icon(Icons.calendar_month),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.notifications),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today`s Tasks",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Friday, 01 Sep",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD5E8FA),
                        foregroundColor: Colors.blue.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        builder: (context) => AddNewTask(),
                      ),
                      child: Text("New Task"),
                    ),
                  ),
                  //scroll mennu
                ],
              ),

              Gap(5),
              //scroll mennu

              ListView.builder(
                itemCount: todoData.value!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Expanded(
                    child: CardTodoWidget(getIndex: index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
