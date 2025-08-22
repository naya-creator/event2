import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/widget/favorite.dart';

import '../Api/dio_consumer.dart';
import '../Api/endpoint.dart';
import '../cubit/events_cubit.dart';
import '../cubit/events_state.dart';
import '../cubit/register_cubit.dart';
import 'places.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EventsCubit(DioConsumer(dio: Dio()))..getAllEvents(),
      child: BlocConsumer<EventsCubit, EventsStatus>(
        listener: (BuildContext context, EventsStatus status) {},
        builder: (context, status) {
          var cubit = EventsCubit.get(context);

          if (status is LoadingEvents) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xfffdb1a1)),
                  SizedBox(height: 10),
                  Text('Please wait...')
                ],
              ),
            );
          } else if (status is ErrorEvents) {
            return Center(child: Text(status.errorMessage));
          } else {
            return SafeArea(
              child: Scaffold(
                endDrawer: Drawer(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 154, 149, 149),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 120,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "User Name",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                      ListTile(
                        title: const Text("Favorites"),
                        leading: const Icon(Icons.favorite),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const HallDisplayApp()));
                        },
                      ),
                      ListTile(
                        title: const Text("Language"),
                        leading: const Icon(Icons.language),
                        onTap: () {},
                      ),
             ListTile(
  title: const Text("Log Out"),
  leading: const Icon(Icons.logout),
  onTap: () {
  context.read<RegisterCubit>().logoutUser(context);
},

),

                      ListTile(
                        title: const Text("Settings"),
                        leading: const Icon(Icons.settings),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    ),
                  ],
                ),
                body: Container(
                  color: const Color(0xfff8f5fb),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 45,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(
                          'Events',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: cubit.allEvents.length,
                          itemBuilder: (context, i) {
                            final event = cubit.allEvents[i];
                            String imageUrl = event.image_event;
                            if (imageUrl.startsWith('/')) {
                              imageUrl = imageUrl.substring(1);
                            }

                            return Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 120,
                                    color: Colors.grey[200],
                                    child: Image.network(
                                      '${Endpoint.imageUrlevent}$imageUrl',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.broken_image,
                                            size: 50);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      event.name_event_en,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    color: Colors.blue,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Places()),
                                      );
                                    },
                                    child: const Text(
                                      "View",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
