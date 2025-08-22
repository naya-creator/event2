import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bottom_navigation_bar_cubit.dart';
import '../cubit/bottom_navigation_bar_status.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit_bottom_navigation_bar(),
      child: BlocConsumer<cubit_bottom_navigation_bar,
          Status_bottom_navigation_bar>(
        listener:
            (BuildContext context, Status_bottom_navigation_bar status) {},
        builder: (BuildContext context, Status_bottom_navigation_bar status) {
          cubit_bottom_navigation_bar keyOfCubit =
              cubit_bottom_navigation_bar.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              elevation: 5,
              shadowColor: Colors.indigo[900],
              titleSpacing: 30,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                elevation: 3,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.indigo[700],
                unselectedItemColor: Colors.black,
                backgroundColor: Colors.deepOrange,
                currentIndex: keyOfCubit.ontap_index_forChangingScreen,
                selectedLabelStyle: const TextStyle(
                    fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                    fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                onTap: (index) {
                  keyOfCubit.function_to_change_the_screens(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                        size: 30,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list_alt_outlined, size: 28),
                      label: 'Orders'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_box_outlined, size: 28),
                      label: 'Profile'),
                ]),
            body: keyOfCubit.Screens[keyOfCubit.ontap_index_forChangingScreen],
          );
        },
      ),
    );
  }
}
