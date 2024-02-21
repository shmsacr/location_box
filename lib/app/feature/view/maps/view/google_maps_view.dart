import 'package:auto_route/auto_route.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:location_box/app/feature/view/home/view_model/home_view_model.dart';
import 'package:location_box/app/feature/view/home/view_model/state/home_state.dart';
import 'package:location_box/app/feature/view/maps/mixin/google_maps_view_mixin.dart';
import 'package:location_box/app/product/model/location/location_model.dart';
import 'package:location_box/app/product/widget/custom_bottom_sheet.dart';
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
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (_context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          appBar: AppBar(
            title: const Text('Google Maps'),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _context.read<HomeViewModel>().deleteCurrentLocation();
                  context.router.pop();
                }),
            actions: [
              IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    CustomBottomSheetHelper(
                      context: context,
                      locationModel: null,
                      state: state,
                    );
                  }),
              IconButton(
                  onPressed: () {
                    googleMapsViewModel.getIt.mapController?.animateCamera(
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
                onTap: (position) {
                  customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  customInfoWindowController.onCameraMove!();
                },
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
                  customInfoWindowController.googleMapController = controller;
                },
                markers: markers.toSet(),
              ),
              CustomInfoWindow(
                controller: customInfoWindowController,
                height: 75,
                width: 150,
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
