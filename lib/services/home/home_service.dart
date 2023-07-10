import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../models/item/item_model.dart';
import '../../repository/item_repository.dart';

// class HomeService extends GetxController{
//   @override
//   void onInit() {
//     // print(">>> HomeService called");
//     super.onInit();
//   }
// }
class HomeService extends GetxController {
  final titleController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final ItemRepository itemRepository = ItemRepository();
  RxList<ItemModel> itemList = <ItemModel>[].obs;
  RxBool isloading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataFromDatabase();
  }

  Future<void> fetchDataFromDatabase() async {
    List<ItemModel>? items = await itemRepository.list();

    itemList.value = items ?? [];
    isloading.value = false;
  }

  Future<void> createItem(ItemModel newItem) async {
    int? id = await itemRepository.create(newItem);
    if (id != null) {
      newItem.id = id;
      itemList.add(newItem);
    }
  }

  Future<void> updateItem(ItemModel updatedItem, id) async {
    updatedItem.id = id;
    await itemRepository.update(id, updatedItem);

    int index = itemList.indexWhere((item) => item.id == id);
    if (index != 1) {
      itemList[index].id = id;
      itemList[index].title = updatedItem.title;
      itemList[index].description = updatedItem.description;
      itemList.refresh();
    }
  }

  Future<void> deleteItem(int? id) async {
    if (id != null) {
      await itemRepository.delete(id);
      itemList.removeWhere((item) => item.id == id);
    }
  }
}
