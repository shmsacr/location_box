import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:location_box/app/feature/view/maps/enum/form_builder_name_enum.dart';
import 'package:location_box/app/feature/view/maps/mixin/google_maps_view_mixin.dart';
import 'package:location_box/app/feature/view/maps/view_model/google_maps_view_model.dart';
import 'package:location_box/app/feature/view/maps/view_model/state/google_maps_state.dart';
import 'package:location_box/gen/assets.gen.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({super.key});

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView>
    with GoogleMapsViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapsViewModel, GoogleMapsState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          appBar: AppBar(
            title: const Text('Google Maps'),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<GoogleMapsViewModel>().deleteCurrentLocation();
                  print('CurrentLOCAAAAAALL : ${state.currentLocation}');

                  context.router.pop();
                }),
            actions: [
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Ink(
                                      child: InkWell(
                                        onTap: () {},
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.image,
                                            size: 100,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Title'),
                                        Text('Address'),
                                      ],
                                    ),
                                  ],
                                ),
                                FormBuilder(
                                  key: googleMapsViewModel.formKey,
                                  child: Column(
                                    children: [
                                      _CustomTextField(
                                        controller:
                                            googleMapsViewModel.titleController,
                                        name: FormNameEnum.title.value,
                                        labelText: 'Title',
                                      ),
                                      _CustomTextField(
                                        controller: googleMapsViewModel
                                            .addressController,
                                        name: FormNameEnum.address.value,
                                        labelText: 'Address',
                                      ),
                                      _CustomTextField(
                                        controller: googleMapsViewModel
                                            .descriptionController,
                                        name: FormNameEnum.description.value,
                                        labelText: 'Description',
                                      ),
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
                                                  .saveLocation();
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
                      });
                },
              ),
              IconButton(
                  onPressed: () {
                    googleMapsViewModel.mapController.animateCamera(
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
                initialCameraPosition: state.currentLocation == null
                    ? const CameraPosition(
                        target: LatLng(42.42796133580664, -102.085749655962),
                        zoom: 14.4746,
                      )
                    : CameraPosition(
                        target: state.currentLocation!,
                        zoom: 14.4746,
                      ),
                onMapCreated: (GoogleMapController controller) {
                  googleMapsViewModel.setMapController(controller);
                },
                markers: state.currentLocation != null
                    ? createMarker(position: state.currentLocation!)
                    : {},
              ),
              if (state.isLoading)
                Container(
                  color: Colors.grey.withOpacity(0.6),
                  child: Center(
                    child: Lottie.asset(
                      Assets.lottie.locationLottie,
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
