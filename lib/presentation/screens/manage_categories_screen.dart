import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:habit_tracker/data/models/category.dart';
import 'package:habit_tracker/presentation/providers/habit_provider.dart';
import 'package:habit_tracker/presentation/providers/theme_provider.dart';
import 'package:habit_tracker/presentation/widgets/add_edit_category_dialog.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/l10n/app_localizations.dart';

class ManageCategoriesScreen extends StatelessWidget {
  const ManageCategoriesScreen({super.key});


 void _showCategoryDialog(BuildContext context, {Category? category}) {
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (ctx) => AddEditCategoryDialog(
        category: category,
        onSave: (name, color) {
          if (category == null) {
            // --- منطق الإضافة ---
            habitProvider.addCategory(name, color.value);
          } else {
            // --- منطق التعديل ---
            habitProvider.updateCategory(category, name, color.value);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: themeProvider.isDarkMode
              ? [const Color(0xFF1D2671), const Color(0xFF2c3e50)]
              : [Colors.teal.shade100, Colors.purple.shade100],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(l10n.manageCategories),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Consumer<HabitProvider>(
          builder: (context, habitProvider, child) {
            final categories = habitProvider.categories;

            if (categories.isEmpty) {
              return Center(
                child: Text(
                  l10n.noCategoriesFound,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final bool isDefaultCategory = category.id == 'general';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface.withOpacity(0.50),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2)),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(category.colorValue),
                            child: isDefaultCategory
                                ? const Icon(Icons.push_pin, size: 18, color: Colors.white)
                                : null,
                          ),
                          title: Text(
                            isDefaultCategory ? l10n.generalCategory : category.name,
                            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: Colors.teal),
                                onPressed: () => _showCategoryDialog(context, category: category),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: isDefaultCategory ? Colors.grey.withOpacity(0.5) : Colors.red.shade300,
                                ),
                                onPressed: isDefaultCategory ? null : () {
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showCategoryDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
