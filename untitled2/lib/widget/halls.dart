
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Api/dio_consumer.dart';
import 'package:untitled2/Api/endpoint.dart';
import 'package:untitled2/cubit/halls_cubit.dart';
import 'package:untitled2/cubit/halls_state.dart';
import 'package:untitled2/widget/halldetails.dart';


class Halls extends StatelessWidget {
  int hallid=0;
  Halls({super.key,required int Hall}) {

    hallid = Hall;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffdb1a1),
        title: const Text("Halls"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
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
          Expanded(
            child: BlocProvider(create: (contex)=>UserCubit2(DioConsumer(dio: Dio()) )..getHalls(hallid),
              child: BlocConsumer<UserCubit2, UserState>(
                listener: (context, state) {
                  if (state is GetHallsFaliure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is GetHallsLoading) {
                    return const Center(child: CircularProgressIndicator( color: Color(0xfffdb1a1)));
                  } else if (state is GetHallsSuccess) {
                    final hallsList = state.halls;

                    if (hallsList.isEmpty) {
                      return const Center(
                          child: Text("لا توجد قاعات متاحة حالياً"));
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: hallsList.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, i) {
                        final hall = hallsList[i];

                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Halldaetails(HallId: hall.HallId,)),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child:
                                       Image.network(
                                    "${Endpoint.imageUrl}${hall.imageUrl1}",
                                    fit: BoxFit.cover,
                                  )

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    hall.nameEn,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Icon(Icons.place),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      hall.locationEn,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 4.0),
                                //   child: Text(
                                //     hall.price,
                                //     style: const TextStyle(
                                //       fontSize: 13,
                                //       color: Colors.green,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                        child: Text("لم يتم تحميل البيانات بعد."));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
