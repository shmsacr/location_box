import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location_box/app/feature/view/home/view_model/home_view_model.dart';
import 'package:location_box/app/feature/view/home/view_model/state/home_state.dart';
import 'package:location_box/app/feature/view/maps/enum/form_builder_name_enum.dart';
import 'package:location_box/app/feature/view/maps/view_model/google_maps_view_model.dart';
import 'package:location_box/app/feature/view/maps/widget/dropdown_widget.dart';
import 'package:location_box/app/product/model/location/location_model.dart';
import 'package:location_box/app/product/model/my_view_model.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

import '../../feature/view/maps/view_model/state/google_maps_state.dart';

import 'package:flutter/material.dart';
import 'dart:io';

class CustomBottomSheetHelper{
   CustomBottomSheetHelper({
    required this.context,
    required this.state,
    required this.locationModel,
    this.isUpdate = false,
  }){
    customBottomSheet();}
  final BuildContext context;
  final HomeState? state;
  final LocationModel? locationModel;
  final bool isUpdate;
  ValueNotifier<File?> _newPicture = ValueNotifier(null);

  Future<void> customBottomSheet() async {
    final MyViewModel getIt = GetIt.instance.get<MyViewModel>();

    if (isUpdate) {
      getIt.titleController.text = locationModel?.title ?? "";
      getIt.addressController.text = locationModel?.address ?? "";
      getIt.descriptionController.text = locationModel?.description ?? "";
      getIt.iconController?.text = locationModel!.iconPath!;
    }

    return showModalBottomSheet<void>(
      
      isScrollControlled: true,
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
                    ValueListenableBuilder(
                      valueListenable: _newPicture,
                      builder: (context, File? value, child) {
                        return Ink(
                          child: InkWell(
                            onTap: () => _buildShowModalBottomSheet(context),
                            child: locationModel?.picture != null
                                ? Image.file(
                                    File(state!.location!.picture!),
                                    width: 100,
                                    height: 100,
                                  )
                                : value == null
                                    ? Stack(
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
                                              color: const Color.fromARGB(
                                                  255, 2, 240, 18),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Image.file(
                                        value,
                                        width: 100,
                                        height: 100,
                                      ),
                          ),
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('latitude: ${state?.latitude}'),
                        Text('longitude: ${state?.longitude}'),
                      ],
                    ),
                  ],
                ),
                FormBuilder(
                  key: getIt.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      _CustomTextField(
                        controller: getIt.titleController,
                        name: FormNameEnum.title.value,
                        labelText: 'Title',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      _CustomTextField(
                        controller: getIt.addressController,
                        name: FormNameEnum.address.value,
                        labelText: 'Address',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      _CustomTextField(
                        controller: getIt.descriptionController,
                        name: FormNameEnum.description.value,
                        labelText: 'Description',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomDropDownWidget(
                        iconController: getIt.iconController,
                        iconPath: isUpdate ? locationModel!.iconPath : null,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.router.pop(),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (isUpdate) {
                          context.read<HomeViewModel>().updateLocation(
                              _newPicture.value, locationModel!.id!);
                        } else {
                          context
                              .read<HomeViewModel>()
                              .saveLocation(_newPicture.value);
                        }
                      },
                      child: Text(isUpdate ? 'Update' : 'Save'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    ).then((value) {
      getIt.titleController.text = "";
      getIt.addressController.text = "";
      getIt.descriptionController.text = "";
      getIt.iconController?.text = "";
      _newPicture.value = null;
    });
  }

  Future<void> _buildShowModalBottomSheet(BuildContext context) async {
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
                "Choose upload type",
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
                      'Camera',
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
                      'Gallery',
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

  Future<ValueNotifier<File?>?> pickPhoto() async {
    if (await _requestGalleryPermission()) {
      XFile? getFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (getFile != null) {
        _newPicture.value = File(getFile.path);

        return _newPicture;
      }
    }
    return null;
  }

  Future<ValueNotifier<File?>?> takePhoto() async {
    if (await _requestCameraPermission()) {
      XFile? getFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (getFile != null) {
        String dir = path.dirname(getFile.path);
        final String pathName = DateFormat("Hms-m-ms-s").format(DateTime.now());
        String newPath = path.join(dir, "location_box_${pathName}.jpg");
        await getFile.saveTo(newPath);
        _newPicture.value = File(newPath);

        return _newPicture;
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
