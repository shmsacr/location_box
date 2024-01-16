import 'package:flutter/material.dart';
import 'package:location_box/app/feature/view/maps/enum/markes_icon_enum.dart';
import 'package:location_box/app/feature/view/maps/widget/mixin/dropdown_mixin.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({super.key, required this.iconController, required this.iconPath});
  final TextEditingController? iconController;
  final String? iconPath;

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> with CustomDropDownWidgetMixin {
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedIcon,
        builder: (BuildContext context, MarkerIcons value, Widget? child) {
          return DropdownButton<MarkerIcons>(
            value: value,
            onChanged: (MarkerIcons? newValue) {
              selectedIcon.value = newValue!;
              widget.iconController?.text = newValue.value;
            },
            items: MarkerIcons.values
                .map<DropdownMenuItem<MarkerIcons>>((MarkerIcons value) {
              return DropdownMenuItem<MarkerIcons>(
                value: value,
                child: Row(
                  children: [
                    Image.asset(value.value, width: 30, height: 30),
                    const SizedBox(width: 10),
                    Text(value.key),
                  ],
                ),
              );
            }).toList(),
          );
        });
  }
}
