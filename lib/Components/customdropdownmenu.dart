import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    required this.label,
    required this.hint,
    required this.items,
    this.currentValue,
    required this.onChanged,
    this.disable,
    Key? key,
  }) : super(key: key);
  final String label;
  final String hint;
  final List<String> items;
  final String? currentValue;
  final ValueChanged<String?> onChanged;
  final bool? disable;

  @override
  Widget build(BuildContext context) {
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
          value: currentValue,
          hint: Text(
            hint,
            style:
                TextStyle(color: disable != true ? Colors.grey : Colors.grey),
          ),
          dropdownColor: thirdLayerColor,
          style: const TextStyle(color: Colors.white),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: disable == false ? onChanged : null,
        )),
      );
    });
  }
}

/*DropdownButtonHideUnderline noBorderDropdownMenu(
    String hint,
    List<String> items,
    String? currentvalue,
    Color hintColor,
    ValueChanged<String?> onChangedValue,
    bool disable) {
  return NoBorderDropdownMenu();
}*/

class NoBorderDropdownMenu extends StatelessWidget {
  const NoBorderDropdownMenu(
      {Key? key,
      required this.hint,
      required this.items,
      required this.onChanged,
      required this.disable,
      this.currentValue,
      this.hintColor})
      : super(key: key);
  final String hint;
  final Color? hintColor;
  final String? currentValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        iconDisabledColor: Colors.grey,
        iconEnabledColor: Colors.white,
        hint: Text(
          hint,
          style: TextStyle(color: hintColor, fontSize: 13),
        ),
        dropdownColor: thirdLayerColor,
        value: currentValue,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: disable ? onChanged : null,
      ),
    );
  }
}
