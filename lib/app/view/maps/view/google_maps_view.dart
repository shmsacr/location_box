import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/product/model/location/location.dart';
import 'package:location_box/app/view/maps/mixin/google_maps_view_mixin.dart';
import 'package:location_box/app/view/maps/view_model/google_maps_view_model.dart';
import 'package:location_box/app/view/maps/view_model/state/google_maps_state.dart';

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
              onPressed: () => Navigator.pop(context),
            ),
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
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        FormBuilderTextField(
                                          name: 'title',
                                          decoration: InputDecoration(
                                            labelText: 'Title',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        FormBuilderTextField(
                                          name: 'address',
                                          decoration: InputDecoration(
                                            labelText: 'Address',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        FormBuilderTextField(
                                          name: 'phoneNumber',
                                          decoration: InputDecoration(
                                            labelText: 'PhoneNumber',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        FormBuilderTextField(
                                          name: 'description',
                                          decoration: InputDecoration(
                                            labelText: 'Description',
                                            border: OutlineInputBorder(),
                                          ),
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
                                                Location location = Location(
                                                  id: 0,
                                                  title: formKey.currentState!
                                                      .value["title"].toString(),
                                                      
                                                  address: formKey.currentState!
                                                      .value['address']
                                                      .toString(),
                                                  latitude: state
                                                      .latitude,
                                                  longitude: state
                                                    
                                                      .longitude,
                                                  phoneNumber: formKey
                                                      .currentState!
                                                      .value['phoneNumber']
                                                      
                                                      .toString(),
                                                  description: formKey
                                                      .currentState!
                                                      .value['description']                                                      .toString(),
                                                );
                                                context
                                                    .read<GoogleMapsViewModel>()
                                                    .saveLocation(location);
                                                if (state.isSaving ?? true) {
                                                  print(location.toJson());
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
                  }),
            ],
          ),
          body: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: state.currentLocation == null
                ? const CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962),
                    zoom: 14.4746,
                  )
                : CameraPosition(
                    target: state.currentLocation!,
                    zoom: 14.4746,
                  ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            markers: state.currentLocation != null ? createMarker() : {},
          ),
        );
      },
    );
  }
}
