import 'package:flutter/material.dart';
import '../../models/item/item_model.dart';
import '../commons/common_widget.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class TodoForm extends StatelessWidget {
  final Function(ItemModel) onSave;
  final TextEditingController initialTitle;
  final TextEditingController initialDescription;
  final bool isEditing;

  const TodoForm({
    Key? key,
    required this.onSave,
    required this.initialTitle,
    required this.initialDescription,
    required this.isEditing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    isEditing ? 'Update Todo' : 'Create Todo',
                    style: CommonWidget.titleText(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: initialTitle,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title cannot be empty!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: initialDescription,
                  maxLines: 3,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description cannot be empty!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final newItem = ItemModel(
                            title: initialTitle.text,
                            description: initialDescription.text,
                          );

                          onSave(newItem);
                          Navigator.pop(context);
                        }
                      },
                      style: CommonWidget.primaryButtonStyle(),
                      child: Text(isEditing ? 'Update' : 'Create'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
