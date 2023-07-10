import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/home/home_service.dart';
import '../../models/item/item_model.dart';
import '../commons/common_widget.dart';
import '../../screens/todo/todo_form.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});
  final HomeService homeService = Get.put(HomeService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User To Do List')),
      body: 
      Obx(
        () => homeService.itemList.isEmpty
            ? const Center(
                child: 
                Text(
                  'No records available!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: homeService.itemList.length,
                      itemBuilder: (BuildContext context, int index) {
                        ItemModel item = homeService.itemList[index];
                        return Card(
                          color:const Color.fromARGB(255, 128, 203, 238),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.note_add,
                              size: 40,
                            ),
                            title: Text(item.title.toString()),
                            subtitle: Text(item.description.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  child: CommonWidget.commonIconButton(
                                    onPressed: () {
                                      homeService.titleController.value.text =
                                          item.title!;
                                      homeService.descriptionController.value
                                          .text = item.description!;
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return TodoForm(
                                            onSave: (updatedItem) {
                                              homeService.updateItem(
                                                  updatedItem, item.id);
                                            },
                                            initialTitle: homeService
                                                .titleController.value,
                                            initialDescription: homeService
                                                .descriptionController.value,
                                            isEditing: true,
                                          );
                                        },
                                      );
                                    },
                                    icon: Icons.edit,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: CommonWidget.commonIconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: const Text(
                                              'Are you sure, you want to delete?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(const EdgeInsets
                                                                    .all(10)),
                                                        shape: MaterialStateProperty
                                                            .all(
                                                                RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        )),
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .white),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .grey)),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: ()  {
                                                      homeService
                                                          .deleteItem(item.id);
                                                      Navigator.pop(context);
                                                    },
                                                    style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(const EdgeInsets
                                                                    .all(10)),
                                                        shape: MaterialStateProperty
                                                            .all(
                                                                RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        )),
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .white),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .red)),
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icons.delete,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeService.titleController.value.text = '';
          homeService.descriptionController.value.text = '';
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return TodoForm(
                onSave: (newItem) async {
                  homeService.createItem(newItem);
                },
                initialDescription: homeService.titleController.value,
                initialTitle: homeService.descriptionController.value,
                isEditing: false,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
