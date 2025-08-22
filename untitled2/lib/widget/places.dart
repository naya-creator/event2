
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/dio_consumer.dart';
import '../cubit/places_cubit.dart';
import '../cubit/places_state.dart';
import 'halls.dart';


class Places extends StatelessWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/images/preview_k-aa-roy-l-ll-htf-l-t-lry-d_L48J8Hwt.jpeg",
      "assets/images/download.jpg",
      "assets/images/download (6).jpg",

    ];
    Size disize = MediaQuery.of(context).size;
    return BlocProvider(create: (context)=>PlacesCubit(DioConsumer(dio:Dio()))..getAllPlaces(),
        child: BlocConsumer<PlacesCubit,Places_Status>
        (listener:(BuildContext context , Places_Status status ){} ,builder:(BuildContext context , Places_Status status){
          if(status is start_places_class) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xfffdb1a1),
              ),
              body:
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          color: Colors.white,
                          height: disize.height,
                          width: disize.width * .5,
                        ),
                        Container(
                          color: const Color(0xfffdb1a1),
                          height: disize.height,
                          width: disize.width * .5,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(75))),
                          height: disize.height * .4,
                          width: disize.width,
                          child: Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    prefixIcon: const Icon(Icons.search),
                                    border: InputBorder.none,
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              const Center(
                                child: Text(
                                  "Places",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfffdb1a1)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            decoration: const BoxDecoration(
                                color: Color(0xfffdb1a1),
                                borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(75))),
                            height: disize.height * .5,
                            width: disize.width,
                           child: const Center(
                             child: CircularProgressIndicator(color: Colors.white,),
                           ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xfffdb1a1),
            ),
            body:
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.white,
                        height: disize.height,
                        width: disize.width * .5,
                      ),
                      Container(
                        color: const Color(0xfffdb1a1),
                        height: disize.height,
                        width: disize.width * .5,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(75))),
                        height: disize.height * .4,
                        width: disize.width,
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  prefixIcon: const Icon(Icons.search),
                                  border: InputBorder.none,
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            const Center(
                              child: Text(
                                "Places",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfffdb1a1)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              color: Color(0xfffdb1a1),
                              borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(75))),
                          height: disize.height * .5,
                          width: disize.width,
                          child:
                          ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index)=>  SizedBox(
                                  width: 300,
                                  height: 400,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 250,
                                        height: 270,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child:

                                        Image.asset(
                                          images[index],
                                          fit: BoxFit.fill,

                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            print(index);
                                          print(PlacesCubit.get(context).allPlaces[index].idPlaces);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context1) => Halls(Hall:PlacesCubit.get(context).allPlaces[index].idPlaces,)));
                                          },
                                          child: Text(
                                            PlacesCubit.get(context).allPlaces[index].nameEn,
                                            style: const TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  )),
                              separatorBuilder:(context,index)=> const SizedBox(
                                width: 20,
                              ), itemCount: PlacesCubit.get(context).allPlaces.length)
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
          }
        } , ),
    );
  }
}
