import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';

FormField<String> customDropmenu(String label, String hint, List<String> items,
    String? currentvalue, ValueChanged<String?> onChangedValue, bool disable) {
  return FormField(builder: (FormFieldState<String> state) {
    return InputDecorator(
      decoration: InputDecoration(
        label: Text(
          label,
        ),
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        icon: Icon(
          Icons.arrow_drop_down,
          color: disable == true ? Colors.grey : Colors.white,
        ),
        isDense: true,
        isExpanded: true,
        elevation: 16,
        value: currentvalue,
        hint: Text(
          hint,
          style: TextStyle(color: disable != true ? Colors.grey : Colors.grey),
        ),
        dropdownColor: thirdLayerColor,
        style: const TextStyle(color: Colors.white),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: disable == false ? onChangedValue : null,
      )),
    );
  });
}
