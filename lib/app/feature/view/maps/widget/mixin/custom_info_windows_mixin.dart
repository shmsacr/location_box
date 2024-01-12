import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/product/model/location/location_model.dart';

mixin CustomInfoWindowsMixin<T extends InfoWindow> on State {
  /// The code snippet is defining a method called `buildInfoWindow` that returns a widget
  Widget buildInfoWindow(
    BuildContext context,
    LocationModel locationModel,
    void Function() onTap,
  ) {
    return Container(
      width: 200,
      height: 100,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.file(
              File(locationModel.picture ?? ''),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locationModel.title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    locationModel.description ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    locationModel.address ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    locationModel.phoneNumber ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}