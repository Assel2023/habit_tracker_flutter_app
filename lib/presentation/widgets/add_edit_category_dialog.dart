import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habit_tracker/data/models/category.dart';
import 'package:habit_tracker/l10n/app_localizations.dart'; 

class AddEditCategoryDialog extends StatefulWidget {
  final Category? category;
  final Function(String name, Color color) onSave;

  const AddEditCategoryDialog({
    super.key,
    this.category,
    required this.onSave,
  });

  @override
  State<AddEditCategoryDialog> createState() => _AddEditCategoryDialogState();
}

class _AddEditCategoryDialogState extends State<AddEditCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late Color _selectedColor;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.category != null;
    _nameController = TextEditingController(text: _isEditing ? widget.category!.name : '');
    _selectedColor = _isEditing ? Color(widget.category!.colorValue) : Colors.teal;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(_nameController.text, _selectedColor);
      Navigator.of(context).pop();
    }
  }

  void _pickColor(AppLocalizations l10n) { 
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.pickAColor), 
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _selectedColor,
            onColorChanged: (color) {
              setState(() => _selectedColor = color);
            },
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(l10n.done), 
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return const AlertDialog(content: SizedBox.shrink()); 
    }

    return AlertDialog(
      title: Text(_isEditing ? l10n.editCategory : l10n.addCategory),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: l10n.categoryName),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.enterACategoryName;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.categoryColor),
                GestureDetector(
                  onTap: () => _pickColor(l10n), 
                  child: CircleAvatar(
                    backgroundColor: _selectedColor,
                    radius: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(l10n.save),
        ),
      ],
    );
  }
}