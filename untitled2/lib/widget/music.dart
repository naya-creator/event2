
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/dio_consumer.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import 'amusic.dart';
import 'emusic.dart';


// ignore: must_be_immutable
class Music extends StatelessWidget {
  Music({super.key});

  @override
  Widget build(BuildContext context) {
  //  context.read<UserCubit>().getMusic();
    return BlocProvider(create: (context)=>UserCubit(DioConsumer(dio:Dio()))..getMusic(),
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffdb1a1),
        title: Text("Music"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            Expanded(
              child: BlocConsumer<UserCubit, UserState2>(
                listener: (context, state) {
                  if (state is GetMusicFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is GetMusicLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetMusicSuccess) {
                    final djList = state.dj;

                    if (djList.isEmpty) {
                      return const Center(
                          child: Text("لا توجد قاعات متاحة حالياً"));
                    }
                    return GridView.builder(
                      itemCount: djList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0, // تعديل المسافة بين الأعمدة
                        childAspectRatio: 2, // نسبة العرض إلى الارتفاع
                      ),
                      itemBuilder: (context, i) {
                        final ddj = djList[i];
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    width: 300,
                                    height: 200,
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Music Type",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(height: 10),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Emusic()));
                                          },
                                          child: Card(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              child: Text("English",
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Amusic()));
                                          },
                                          child: Card(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              child: Text("عربية",
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    ddj.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
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
          ],
        ),
      ),
    ));
  }
}
