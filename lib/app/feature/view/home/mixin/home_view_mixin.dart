


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_box/app/feature/view/home/view/home_view.dart';
import 'package:location_box/app/feature/view/home/view_model/home_view_model.dart';

mixin HomeViewMixin on State<HomeView>{
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(changeState);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void changeState(){
    context.read<HomeViewModel>().searchLocation(searchController.text);
  }
}