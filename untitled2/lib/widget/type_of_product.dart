import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../cubit/bottom_navigation_bar_cubit.dart';
import '../cubit/bottom_navigation_bar_status.dart';

class TypeOfProduct extends StatelessWidget {
  TypeOfProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => cubit_bottom_navigation_bar(),
        child: BlocConsumer<cubit_bottom_navigation_bar,
            Status_bottom_navigation_bar>(
          listener: (context, Status_bottom_navigation_bar status) {},
          builder: (context, Status_bottom_navigation_bar status) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.list_outlined,
                        size: 30,
                        color: Colors.black,
                      ))
                ],
                backgroundColor: Colors.deepOrange,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'number of product you choose :  0',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 90,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green),
                            child: Center(child: Text('SEND')),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 90,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red),
                            child: Center(child: Text('CANCEL')),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => mycolumn(context),
                          itemCount: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

Widget mycolumn(BuildContext context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {},
        child: Container(
          height: 270,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image(
            image: AssetImage(
              "assets/images/shopping.webp",
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
          ),
          Text("on tabels",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          Spacer(),
          IconButton(
            onPressed: () {
              cubit_bottom_navigation_bar
                  .get(context)
                  .function_changeFromAddIconToAddedSuccessfully();
            },
            icon: cubit_bottom_navigation_bar
                    .get(context)
                    .changeFromAddIconToAddedSuccessfully
                ? Icon(
                    Icons.offline_pin_outlined,
                    color: Colors.deepOrange,
                    size: 30,
                  )
                : Icon(
                    Icons.add_box,
                    color: Colors.deepOrange,
                    size: 30,
                  ),
          ),
          SizedBox(
            width: 40,
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
