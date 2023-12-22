import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_box/app/product/navigation/app_router.dart';
import 'package:location_box/app/view/maps/view_model/google_maps_view_model.dart';
import 'package:location_box/app/view/maps/view_model/state/google_maps_state.dart';

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
        if (state.locations != null) {
          return ListView.builder(
              itemCount: state.locations!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.locations![index].title!),
                  subtitle: Text(state.locations![index].address!),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context
                          .read<GoogleMapsViewModel>()
                          .deleteLocation(state.locations![index]);
                    },
                  ),
                );
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
