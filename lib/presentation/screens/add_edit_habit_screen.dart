import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/data/models/habit.dart';
import 'package:habit_tracker/presentation/providers/habit_provider.dart';
import 'package:habit_tracker/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/data/models/frequency_type.dart';
import 'package:habit_tracker/l10n/app_localizations.dart';
import 'dart:ui';

class AddEditHabitScreen extends StatefulWidget {
  final Habit? habit;
  const AddEditHabitScreen({super.key, this.habit});

  @override
  State<AddEditHabitScreen> createState() => _AddEditHabitScreenState();
}

class _AddEditHabitScreenState extends State<AddEditHabitScreen> {
  bool _reminderEnabled = false;
  TimeOfDay? _selectedTime;
  FrequencyType _selectedFrequency = FrequencyType.daily;
  bool _isChallenge = false;
  final _durationController = TextEditingController();
  final Set<int> _selectedDays = {};

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String? _selectedCategoryId;

  int? _selectedIconCodePoint;
  Color? _selectedColor;
  bool _isEditing = false;

  final List<IconData> _icons = [
    FontAwesomeIcons.personRunning,
    FontAwesomeIcons.bookOpen,
    FontAwesomeIcons.glassWater,
    FontAwesomeIcons.appleWhole,
    FontAwesomeIcons.dumbbell,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.computer,
    FontAwesomeIcons.dollarSign,
    FontAwesomeIcons.pray,
    FontAwesomeIcons.code,
  ];

  final List<Color> _colors = [
    Colors.teal,
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.green,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
  ];

  @override
  @override
  @override
  void initState() {
    super.initState();

    if (widget.habit != null) {
      _isEditing = true;
      final habit = widget.habit!;

      _nameController.text = habit.name;
      _selectedIconCodePoint = habit.iconCodePoint;
      _selectedColor = Color(habit.colorValue);

      _reminderEnabled = habit.reminderEnabled;
      _selectedCategoryId = widget.habit!.categoryId;

      if (habit.reminderTime != null) {
        final timeParts = habit.reminderTime!.split(':');
        _selectedTime = TimeOfDay(
          hour: int.parse(timeParts[0]),
          minute: int.parse(timeParts[1]),
        );
      } else {
        _selectedTime = const TimeOfDay(hour: 8, minute: 0);
      }

      _selectedFrequency = habit.frequencyType;
      if (habit.frequencyDays != null) {
        _selectedDays.addAll(habit.frequencyDays!);
      }

      _isChallenge = habit.isChallenge;
      if (_isChallenge && habit.challengeDuration != null) {
        _durationController.text = habit.challengeDuration.toString();
      }
    } else {
      _isEditing = false;

      _selectedIconCodePoint = FontAwesomeIcons.personRunning.codePoint;
      _selectedColor = Colors.teal;
      _reminderEnabled = false;
      _selectedTime = const TimeOfDay(hour: 8, minute: 0);
      _selectedFrequency = FrequencyType.daily;
      _isChallenge = false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _saveHabit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedFrequency == FrequencyType.specificDays &&
          _selectedDays.isEmpty) {
        final l10n = AppLocalizations.of(context)!;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.selectAtLeastOneDay),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final habitProvider = Provider.of<HabitProvider>(context, listen: false);

      final String? reminderTimeString = _reminderEnabled &&
              _selectedTime != null
          ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
          : null;

      final int? challengeDuration =
          _isChallenge && _durationController.text.isNotEmpty
              ? int.tryParse(_durationController.text)
              : null;

      if (_isEditing) {
        final updatedHabit = widget.habit!;

        updatedHabit.name = _nameController.text;
        updatedHabit.iconCodePoint = _selectedIconCodePoint!;
        updatedHabit.colorValue = _selectedColor!.value;
        updatedHabit.reminderEnabled = _reminderEnabled;
        updatedHabit.reminderTime = reminderTimeString;
        updatedHabit.frequencyType = _selectedFrequency;
        updatedHabit.frequencyDays =
            _selectedFrequency == FrequencyType.specificDays
                ? _selectedDays.toList()
                : null;
        updatedHabit.isChallenge = _isChallenge;
        updatedHabit.challengeDuration = challengeDuration;

        habitProvider.updateHabit(updatedHabit);

        Navigator.of(context).pop();
      } else {
        habitProvider.addHabit(
          _nameController.text,
          _selectedIconCodePoint!,
          _selectedColor!.value,
          _reminderEnabled,
          reminderTimeString,
          _selectedFrequency,
          _selectedFrequency == FrequencyType.specificDays
              ? _selectedDays.toList()
              : null,
          _isChallenge,
          challengeDuration,
          _selectedCategoryId!,
        );

        Navigator.of(context).pop();
      }
    }
  }

  InputDecoration _glassInputDecoration(String label, {Widget? prefixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle:
          TextStyle(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7)),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon.key as IconData?,
              color: Colors.white.withOpacity(0.7))
          : null,
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 246, 246).withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (l10n == null)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
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
          title: Text(_isEditing ? l10n.editHabit : l10n.addHabit),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  decoration: _glassInputDecoration(l10n.habitName,
                      prefixIcon: const Icon(Icons.edit_note)),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? l10n.enterHabitName
                      : null,
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                Consumer<HabitProvider>(
                  builder: (context, habitProvider, child) {
                    if (habitProvider.categories.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!_isEditing && _selectedCategoryId == null) {
                      _selectedCategoryId = habitProvider.categories.first.id;
                    }

                    return DropdownButtonFormField<String>(
                      value: _selectedCategoryId,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: _glassInputDecoration(l10n.category),
                      dropdownColor: const Color(0xFF2c3e50),
                      items: [
                        for (final category in habitProvider.categories)
                          DropdownMenuItem(
                            value: category.id,
                            child: Text(category.name),
                          )
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategoryId = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? l10n.selectCategory : null,
                    );
                  },
                ),
               const SizedBox(height: 24),
                Text(l10n.chooseAnIcon,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          6, 
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _icons.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final icon = _icons[index];
                      final isSelected =
                          icon.codePoint == _selectedIconCodePoint;

                      return GestureDetector(
                        onTap: () => setState(
                            () => _selectedIconCodePoint = icon.codePoint),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? _selectedColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            icon,
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                            size: 28,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),
                Text(l10n.chooseAColor,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _colors.length,
                    itemBuilder: (context, index) {
                      final color = _colors[index];
                      final isSelected = color.value == _selectedColor?.value;

                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = color),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 50,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 24)
                              : null,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                  ),
                ),
                const SizedBox(height: 32),

                const SizedBox(height: 16),

                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    title: Text(l10n.advancedSettings),
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(height: 1),
                          const SizedBox(height: 16),

                          const SizedBox(height: 16),
                          Text(l10n.frequency,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          SegmentedButton<FrequencyType>(
                            segments: <ButtonSegment<FrequencyType>>[
                              ButtonSegment(
                                  value: FrequencyType.daily,
                                  label: Text(l10n.daily)),
                              ButtonSegment(
                                  value: FrequencyType.specificDays,
                                  label: Text(l10n.specificDays)),
                            ],
                            selected: {_selectedFrequency},
                            onSelectionChanged:
                                (Set<FrequencyType> newSelection) {
                              setState(() {
                                _selectedFrequency = newSelection.first;
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          if (_selectedFrequency == FrequencyType.specificDays)
                            _buildDaySelector(),

                          const SizedBox(height: 24),
                          const Divider(height: 32),
                          SwitchListTile(
                            title: Text(l10n.makeItAChallenge,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Text(l10n.setADuration),
                            value: _isChallenge,
                            onChanged: (bool value) {
                              setState(() {
                                _isChallenge = value;
                              });
                            },
                          ),
                          if (_isChallenge)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: _durationController,
                                    decoration: InputDecoration(
                                      labelText: l10n.durationInDays,
                                      border: const OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType
                                        .number, 
                                    validator: (value) {
                                      if (_isChallenge) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return l10n
                                              .enterADuration; 
                                        }
                                        if (int.tryParse(value) == null ||
                                            int.parse(value) <= 0) {
                                          return l10n
                                              .enterAValidNumber; 
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing:
                                        4.0, 
                                    children:
                                        [7, 21, 30, 60, 90, 100].map((days) {
                                      return ActionChip(
                                        label: Text(
                                            l10n.daysSuffix(days.toString())),
                                        onPressed: () {
                                          _durationController.text =
                                              days.toString();
                                          FocusScope.of(context).unfocus();
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),

                          const Divider(height: 32),
                          SwitchListTile(
                            title: Text(l10n.enableDailyReminder,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            value: _reminderEnabled,
                            onChanged: (bool value) {
                              setState(() {
                                _reminderEnabled = value;
                              });
                            },
                          ),
                          if (_reminderEnabled)
                            ListTile(
                              title: Text(l10n.reminderTime),
                              trailing: Text(_selectedTime?.format(context) ??
                                  l10n.selectTime),
                              onTap: () async {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime ?? TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    _selectedTime = pickedTime;
                                  });
                                }
                              },
                            ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _saveHabit,
                  icon: const Icon(Icons.check_rounded),
                  label: Text(_isEditing ? l10n.saveChanges : l10n.saveHabit),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    backgroundColor: _selectedColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDaySelector() {
    final weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final dayIndex = index + 1; 
        final isSelected = _selectedDays.contains(dayIndex);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedDays.remove(dayIndex);
              } else {
                _selectedDays.add(dayIndex);
              }
            });
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: isSelected ? _selectedColor : Colors.grey.shade300,
            child: Text(
              weekDays[index],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }
}
