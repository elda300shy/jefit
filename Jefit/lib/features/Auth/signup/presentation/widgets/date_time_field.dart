import 'package:flutter/material.dart';
import 'package:jefit/core/common/widget/app_text_form_field.dart';

class DateTimeField extends StatefulWidget {
  const DateTimeField({super.key, required this.dateSelector});
  final Function(String) dateSelector;

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.dateSelector('${picked.month}-${picked.day}-${picked.year}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: AppTextFormField(
                hintText: _selectedDate == null
                    ? "Select Date"
                    : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                validator: (value) {
                  if (_selectedDate == null) {
                    return "Date is required";
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
