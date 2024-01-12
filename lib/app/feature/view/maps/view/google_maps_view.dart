import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:location_box/app/feature/view/maps/enum/form_builder_name_enum.dart';
import 'package:location_box/app/feature/view/maps/mixin/google_maps_view_mixin.dart';
import 'package:location_box/app/feature/view/maps/view_model/google_maps_view_model.dart';
import 'package:location_box/app/feature/view/maps/view_model/state/google_maps_state.dart';
import 'package:location_box/app/feature/view/maps/widget/dropdown_widget.dart';
import 'package:location_box/app/feature/view/maps/widget/mixin/custom_info_windows_mixin.dart';
import 'package:location_box/app/product/model/location/location_model.dart';
import 'package:lottie/lottie.dart';

import '../../../../../gen/src/asset/assets.gen.dart';

@RoutePage()
class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({super.key, this.locationModel});
  final LocationModel? locationModel;
  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView>
    with GoogleMapsViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapsViewModel, GoogleMapsState>(
      builder: (_context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          appBar: AppBar(
            title: const Text('Google Maps'),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _context.read<GoogleMapsViewModel>().deleteCurrentLocation();
                  context.router.pop();
                }),
            actions: [
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  showModalBottomSheet<void>(
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
                                        onTap: () =>
                                            buildShowModalBottomSheet(_context),
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
                                                          const Color.fromARGB(
                                                              255, 2, 240, 18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('latitude: ${state.latitude}'),
                                        Text('longitude: ${state.longitude}'),
                                      ],
                                    ),
                                  ],
                                ),
                                FormBuilder(
                                  key: googleMapsViewModel.formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      _CustomTextField(
                                        controller:
                                            googleMapsViewModel.titleController,
                                        name: FormNameEnum.title.value,
                                        labelText: 'Title',
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      _CustomTextField(
                                        controller: googleMapsViewModel
                                            .addressController,
                                        name: FormNameEnum.address.value,
                                        labelText: 'Address',
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      _CustomTextField(
                                        controller: googleMapsViewModel
                                            .descriptionController,
                                        name: FormNameEnum.description.value,
                                        labelText: 'Description',
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      CustomDropDownWidget(iconController: googleMapsViewModel.iconController),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () =>
                                                context.router.pop(),
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context
                                                  .read<GoogleMapsViewModel>()
                                                  .saveLocation(imageFile);
                                              if (state.isSaving) {
                                                print(
                                                    'state : ${state.locations}');
                                              }
                                            },
                                            child: Text('Save'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).then((value) => setState(() {
                        imageFile = null;
                      }));
                  ;
                },
              ),
              IconButton(
                  onPressed: () {
                    googleMapsViewModel.mapController?.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: state.currentLocation!,
                          zoom: 14.4746,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.my_location))
            ],
          ),
          body: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: widget.locationModel == null
                    ? CameraPosition(
                        target: state.currentLocation!,
                        zoom: 14.4746,
                      )
                    : CameraPosition(
                        target: LatLng(
                          widget.locationModel!.latitude!,
                          widget.locationModel!.longitude!,
                        ),
                        zoom: 14.4746,
                      ),
                onMapCreated: (GoogleMapController controller) {
                  googleMapsViewModel.setMapController(controller);
                },
                markers: state.markers!.toSet(),
              ),
              if (state.isLoading)
                Container(
                  color: Colors.grey.withOpacity(0.6),
                  child: Center(
                    child: Lottie.asset(
                      Assets.lottie.locationLottie.path,
                      width: context.sized.width * 0.5,
                      height: context.sized.height * 0.5,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

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
