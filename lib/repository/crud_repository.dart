import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import '../services/entity_service/entity_service.dart';

// abstract class CRUDModel<E> {
//   Future<List<E>?> list();
//   Future<E?> getById(id);
//   Future<int?> create(Map<String, Object> data);
//   Future<int?> update(id, Map<String, Object> data);
//   Future<int?> delete(id);
//   Database get database => entityService.database;
// }

abstract class CRUDRepository<E>{
  Future<List<E>?>  list();
  Future<E?> getById(id);
  Future<int?> create(E data);
  Future<int?> update(id,E data);
  Future<int?> delete(id);

  Database get database => Get.find<EntityService>().database;
}
