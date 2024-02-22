import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_box/app/feature/view/home/mixin/home_view_mixin.dart';
import 'package:location_box/app/feature/view/home/view_model/home_view_model.dart';
import 'package:location_box/app/feature/view/home/view_model/state/home_state.dart';
import 'package:location_box/app/feature/view/home/widget/customBoxDecoration.dart';
import 'package:location_box/app/product/extension/context_extension.dart';
import 'package:location_box/app/product/init/state/theme/view_model.dart';
import 'package:location_box/app/product/navigation/app_router.dart';
import 'package:location_box/app/product/widget/custom_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {},
                ),
                Switch(
                    value: context.watch<AppThemeViewModel>().state.isDarkMode,
                    onChanged: (value) {
                      context
                          .read<AppThemeViewModel>()
                          .setThemeMode(themeMode: value);
                    })
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.router.push(GoogleMapsRoute());
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
              title: state.isSearching
                  ? SizedBox(
                      height: context.height * 0.066,
                      child: TextField(
                        controller: searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefix: Icon(Icons.search),
                          suffix: IconButton(
                            onPressed: () {
                              context.read<HomeViewModel>().clearSearch();
                              searchController.clear();
                            },
                            icon: Icon(Icons.clear_sharp),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.circular(context.lowValue),
                          ),
                          enabledBorder: InputBorder.none,
                          hintText: 'Search Location',
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  : Text('Location Box'),
              flexibleSpace: Container(
                decoration: CustomBoxDecoration.getBoxDecoration(context),
              ),
              actions: [
                state.isSearching
                    ? IconButton(
                        onPressed: () {
                          context.read<HomeViewModel>().clearSearch();
                          searchController.clear();
                        },
                        icon: Icon(Icons.close))
                    : IconButton(
                        onPressed: () {
                          context.read<HomeViewModel>().searchLocation('');
                        },
                        icon: Icon(Icons.search)),
              ]),
          body: state.isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  decoration: CustomBoxDecoration.getBoxDecoration(context),
                  child: (state.locations != null &&
                          state.locations!.isNotEmpty)
                      ? ListView.builder(
                          itemCount: state.locations?.length,
                          itemBuilder: (context, index) {
                            return CustomCardWidget(state: state, index: index);
                          },
                        )
                      : (state.isSearching)
                          ? Center(
                              child: Text('No found Location'),
                            )
                          : Center(
                              child: TextButton(
                                child: Text('Add Location'),
                                onPressed: () {
                                  context.router.push(GoogleMapsRoute());
                                },
                              ),
                            ),
                ),
        );
      },
    );
  }
}

class CustomCardWidget extends StatelessWidget {
  final HomeState state;
  final int index;
  const CustomCardWidget({
    super.key,
    required this.state,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              state.locations![index].picture != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(state.locations![index].picture!),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      child: Icon(Icons.image, size: 100),
                    ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.locations![index].title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      state.locations![index].description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    state.locations![index].address!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    context.router.push(GoogleMapsRoute(
                        locationModel: state.locations![index]));
                  },
                  icon: Icon(Icons.location_on)),
              IconButton(
                  onPressed: () => CustomBottomSheetHelper(
                      context: context,
                      isUpdate: true,
                      state: null,
                      locationModel: state.locations![index]),
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    Share.share(
                        "https://www.google.com/maps/search/?api=1&query=${state.locations![index].latitude},${state.locations![index].longitude}");
                  },
                  icon: Icon(Icons.share)),
              IconButton(
                  onPressed: () {
                    context
                        .read<HomeViewModel>()
                        .deleteLocation(state.locations![index].id!);
                  },
                  icon: Icon(Icons.delete)),
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
            ],
          ),
        ],
      ),
    );
  }
}
