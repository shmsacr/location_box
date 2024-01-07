import 'package:flutter/material.dart';
import 'package:location_box/app/feature/view/maps/enum/markes_icon_enum.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({super.key, required this.iconController});
  final TextEditingController? iconController;

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<MarkerIcons>(
        initialSelection: MarkerIcons.ic_default,
        controller: widget.iconController,
        leadingIcon: widget.iconController?.value.text != null
            ? Image.asset(MarkerIcons.ic_default.value, width: 30, height: 30)
            : Image.asset(MarkerIcons.ic_default.value, width: 30, height: 30),
        label: const Text('Icon'),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
        ),
        onSelected: (MarkerIcons? icon) {
          if (icon != null) {
            debugPrint('Selected ${widget.iconController?.text}');
            debugPrint('Selected ${widget.iconController?.value.text}');
            debugPrint('Selected ${widget.iconController?.value}');
          }
        },
        dropdownMenuEntries:
            MarkerIcons.values.map<DropdownMenuEntry<MarkerIcons>>(
          (MarkerIcons icon) {
            return DropdownMenuEntry<MarkerIcons>(
              value: icon,
              label: icon.key,

              leadingIcon: Image.asset(icon.value, width: 30, height: 30),
            );
          },
        ).toList());
  }
}
