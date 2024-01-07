import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_box/app/feature/view/maps/view_model/google_maps_view_model.dart';
import 'package:location_box/app/feature/view/maps/view_model/state/google_maps_state.dart';
import 'package:location_box/app/product/navigation/app_router.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: Text('Material App Bar'),
      ),
      body: BlocBuilder<GoogleMapsViewModel, GoogleMapsState>(
          builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.locations != null && state.locations!.isNotEmpty) {
          return ListView.builder(
              itemCount: state.locations!.length,
              itemBuilder: (context, index) {
                return CustomCardWidget(state: state, index: index);
              });
        } else {
          return Center(
              child: TextButton(
                  child: Text('Add Location'),
                  onPressed: () {
                    context.router.push(GoogleMapsRoute());
                  }));
        }
      }),
    );
  }
}

class CustomCardWidget extends StatelessWidget {
  final GoogleMapsState state;
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
                  ? Container(
                      child: Image.file(
                        File(state.locations![index].picture!),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      child: Icon(Icons.image, size: 100),
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.locations![index].title!),
                  Text(state.locations![index].address!),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.location_on)),
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    Share.share("https://www.google.com/maps/search/?api=1&query=${state.locations![index].latitude},${state.locations![index].longitude}");
                  },
                  icon: Icon(Icons.share)),
              IconButton(
                  onPressed: () {
                    context
                        .read<GoogleMapsViewModel>()
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
