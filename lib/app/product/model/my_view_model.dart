// my_view_model.dart

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyViewModel {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController? _iconController = TextEditingController();
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  GoogleMapController? _mapController;

  TextEditingController get addressController => _addressController;
  set addressController(TextEditingController value) {
    _addressController = value;
  }

  TextEditingController get descriptionController => _descriptionController;
  set descriptionController(TextEditingController value) {
    _descriptionController = value;
  }

  TextEditingController get imageController => _imageController;
  set imageController(TextEditingController value) {
    _imageController = value;
  }

  TextEditingController get phoneController => _phoneController;
  set phoneController(TextEditingController value) {
    _phoneController = value;
  }

  TextEditingController get titleController => _titleController;
  set titleController(TextEditingController value) {
    _titleController = value;
  }

  TextEditingController? get iconController => _iconController;
  set iconController(TextEditingController? value) {
    _iconController = value;
  }

  GlobalKey<FormBuilderState> get formKey => _formKey;
  set formKey(GlobalKey<FormBuilderState> value) {
    _formKey = value;
  }

  GoogleMapController? get mapController => _mapController;
  set mapController(GoogleMapController? value) {
    _mapController = value;
  }
}
