import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location_box/app/feature/view/maps/enum/form_builder_name_enum.dart';
import 'package:location_box/app/feature/view/maps/view_model/google_maps_view_model.dart';
import 'package:location_box/app/product/model/location/location_model.dart';
import 'package:location_box/main.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

import '../../feature/view/maps/view_model/state/google_maps_state.dart';

Future<void> customBottomSheet(
    {required BuildContext context,
    required LocationModel? locationModel,
    required GlobalKey? key,
    required GoogleMapsState state}) async {
  return await showModalBottomSheet<void>(
    context: context,
    builder: (_) {
      return SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Ink(
                    child: InkWell(
                      onTap: () => buildShowModalBottomSheet(context),
                      child: locationModel?.picture != null
                          ? Image.file(
                              File(locationModel!.picture!),
                              width: 100,
                              height: 100,
                            )
                          : Stack(
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 100,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                    weight: 100,
                                    color:
                                        const Color.fromARGB(255, 2, 240, 18),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

/* Future<void> newMethod(
    BuildContext _context, BuildContext context, GoogleMapsState state) {
  return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: _context,
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Ink(
                      child: InkWell(
                        onTap: () => buildShowModalBottomSheet(_context),
                        child: imageFile != null
                            ? Image.file(
                                imageFile!,
                                width: 100,
                                height: 100,
                              )
                            : Stack(
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 100,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Icon(
                                      Icons.add,
                                      size: 30,
                                      weight: 100,
                                      color:
                                          const Color.fromARGB(255, 2, 240, 18),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('latitude: ${state.latitude}'),
                        Text('longitude: ${state.longitude}'),
                      ],
                    ),
                  ],
                ),
                newMethodd(context, state),
              ],
            ),
          ),
        );
      });
}

FormBuilder newMethodd(BuildContext context, GoogleMapsState state) {
  return FormBuilder(
    key: googleMapsViewModel.formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        _CustomTextField(
          controller: googleMapsViewModel.titleController,
          name: FormNameEnum.title.value,
          labelText: 'Title',
        ),
        SizedBox(
          height: 16,
        ),
        _CustomTextField(
          controller: googleMapsViewModel.addressController,
          name: FormNameEnum.address.value,
          labelText: 'Address',
        ),
        SizedBox(
          height: 16,
        ),
        _CustomTextField(
          controller: googleMapsViewModel.descriptionController,
          name: FormNameEnum.description.value,
          labelText: 'Description',
        ),
        SizedBox(
          height: 16,
        ),
        CustomDropDownWidget(
            iconController: googleMapsViewModel.iconController),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => context.router.pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<GoogleMapsViewModel>().saveLocation(imageFile);
                if (state.isSaving) {
                  print('state : ${state.locations}');
                }
              },
              child: Text('Save'),
            ),
          ],
        )
      ],
    ),
  );
}
 */
Future<void> buildShowModalBottomSheet(BuildContext context) async {
  return await showModalBottomSheet<void>(
    context: context,
    builder: (_) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Lütfen yükleme tipini seçiniz",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            InkWell(
              onTap: () async {
                await takePhoto();
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Kamera',
                    style: TextStyle(color: Colors.purple),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            InkWell(
              onTap: () async {
                await pickPhoto();
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.image,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Galeri',
                    style: TextStyle(color: Colors.purple),
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String labelText;
  const _CustomTextField({
    super.key,
    required this.controller,
    required this.name,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: controller,
      name: name,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}

Future<File?> pickPhoto() async {
  if (await _requestGalleryPermission()) {
    XFile? getFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (getFile != null) {
      return File(getFile.path);
    }
  }
  return null;
}

Future<File?> takePhoto() async {
  if (await _requestCameraPermission()) {
    XFile? getFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (getFile != null) {
      String dir = path.dirname(getFile.path);
      final String pathName = DateFormat("Hms-m-ms-s").format(DateTime.now());
      String newPath = path.join(dir, "location_box_${pathName}.jpg");
      await getFile.saveTo(newPath);

      return File(newPath);
    }
  }
  return null;
}

Future<bool> _requestGalleryPermission() async {
  var status = await Permission.storage.status;
  print(status);
  if (status.isGranted) {
    return true;
  } else {
    var result = await Permission.storage.request();
    return result.isGranted;
  }
}

Future<bool> _requestCameraPermission() async {
  var status = await Permission.camera.status;
  print(status);
  if (status.isGranted) {
    return true;
  } else {
    var result = await Permission.camera.request();
    return result.isGranted;
  }
}
