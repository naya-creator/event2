import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/events.dart';
import '../widget/home_page.dart';
import '../widget/orders_of_user.dart';
import '../widget/profile_of_user.dart';
import 'bottom_navigation_bar_status.dart';

class cubit_bottom_navigation_bar extends Cubit<Status_bottom_navigation_bar> {
  cubit_bottom_navigation_bar() : super(inital_bottom());

  static cubit_bottom_navigation_bar get(context) => BlocProvider.of(context);

  int ontap_index_forChangingScreen = 0;

// this is a list contain the screens to change the screen when the user top on the specific icon //

  List<Widget> Screens = [
     Events(),
    const Getreservation(),
   Profile()
  ];

// this is a list which contain titles to use in appbar //
  List<String> Titles = ["Home", "Orders", "Profile"];

// this is a function which changing the screen //

  void function_to_change_the_screens(int theCurrentIndex) {
    ontap_index_forChangingScreen = theCurrentIndex;

    emit(status_of_changing_screens());
  }

/*
* new screen => type of product                   */

  bool changeFromAddIconToAddedSuccessfully = false;

  void function_changeFromAddIconToAddedSuccessfully() {
    changeFromAddIconToAddedSuccessfully =
        !changeFromAddIconToAddedSuccessfully;
    emit(status_of_changing_Add_icons());
  }
}
