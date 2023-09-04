import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_fire/provider/service_provider.dart';

class CardTodoWidget extends ConsumerWidget {
  const CardTodoWidget({Key? key, required this.getIndex}) : super(key: key);

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchSteamProvider);
    return todoData.when(
      data: (response) {
        Color colorCategory = Colors.white;

        final getCategory = response[getIndex].category;
        switch (getCategory) {
          case 'Learning':
            colorCategory = Colors.green;
            break;
          case 'Working':
            colorCategory = Colors.blue.shade700;
            break;
          case 'General':
            colorCategory = Colors.amber.shade700;
            break;
        }

        return Container(
          width: double.infinity,
          height: 130,
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                decoration: BoxDecoration(
                  color: colorCategory,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          onPressed: () => ref
                              .read(serviceProvider)
                              .deleteTask(response[getIndex].docID),
                          icon: Icon(
                            CupertinoIcons.trash,
                            color: Colors.red,
                          ),
                        ),
                        title: Text(
                          response[getIndex].titleTask,
                          maxLines: 1,
                          style: TextStyle(
                            decoration: response[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          response[getIndex].description,
                          maxLines: 1,
                          style: TextStyle(
                            decoration: response[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            value: response[getIndex].isDone,
                            shape: CircleBorder(),
                            activeColor: Colors.blue,
                            onChanged: (value) => ref
                                .read(serviceProvider)
                                .updateTask(response[getIndex].docID, value),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -12),
                        child: Container(
                          child: Column(children: [
                            Divider(
                              thickness: 1.5,
                              color: Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                children: [
                                  Text(response[getIndex].date),
                                  Gap(10),
                                  Text(response[getIndex].time)
                                ],
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      error: (error, stackTrack) => Center(
        child: Text('Error'),
      ),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
