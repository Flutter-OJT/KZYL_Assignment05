/// The model to perform the CRUD operations
///
/// author KyawZayarLynn
class ItemModel {
  int? id;
  String? title;
  String? description;
  String? owner;

  ItemModel({
    this.id,
    required this.title,
    required this.description,
    
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
