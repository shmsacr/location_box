import 'package:flutter/material.dart';
import 'package:location_box/app/feature/view/maps/enum/markes_icon_enum.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({super.key});

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  final TextEditingController iconController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<MarkerIcons>(
        controller: iconController,
        enableFilter: true,
        requestFocusOnTap: true,
        leadingIcon: const Icon(Icons.search),
        label: const Text('Icon'),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
        ),
        onSelected: (MarkerIcons? icon) {},
        dropdownMenuEntries:
            MarkerIcons.values.map<DropdownMenuEntry<MarkerIcons>>(
          (MarkerIcons icon) {
            return DropdownMenuEntry<MarkerIcons>(
              value: icon,
              label: icon.key,
              leadingIcon: Image.asset(icon.value),
            );
          },
        ).toList());
  }
}
