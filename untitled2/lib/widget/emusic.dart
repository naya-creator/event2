
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import '../models/music_model.dart';

// ignore: must_be_immutable
class Emusic extends StatefulWidget {
  Emusic({super.key});

  @override
  State<Emusic> createState() => _EmusicState();
}

class _EmusicState extends State<Emusic> {
  Set<int> selectedIndexes = {}; // لتتبع الأغاني المختارة

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getMusic(); // طلب البيانات عند بدء الواجهة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/mus.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 55,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          Center(
            child:
            BlocConsumer<UserCubit, UserState2>(listener: (context, state) {
              if (state is GetMusicFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
              if (state is ReservSongerLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }

              if (state is ReservSongerSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("تم الحجز بنجاح")),
                );
                context.read<UserCubit>().getMusic();
              }

              if (state is ReservSongerFailure) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("فشل الحجز")),
                );
                context.read<UserCubit>().getMusic();
              }
            }, builder: (context, state) {
              if (state is GetMusicLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetMusicSuccess) {
                final List<MusicModel> englishSongsList = state.englishSongs;

                if (englishSongsList.isEmpty) {
                  return const Center(
                      child: Text("لا توجد أغانٍ عربية حالياً"));
                }

                return Container(
                  margin: EdgeInsets.all(70),
                  child: Column(
                    children: [
                      Text(
                        "Choose Music",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: englishSongsList.length,
                          itemBuilder: (context, i) {
                            final song = englishSongsList[i];
                            return CheckboxListTile(
                              checkColor: Colors.black,
                              activeColor: Colors.white,
                              title: Text(song.title),
                              subtitle: Text(song.artist),
                              value: selectedIndexes.contains(i),
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    selectedIndexes.add(i);
                                  } else {
                                    selectedIndexes.remove(i);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.blue,
                        onPressed: () {
                          final cubit = context.read<UserCubit>();
                          final state = cubit.state;

                          const int reservationId = 10;
                          const int coordinatorId = 2;
                          const int serviceId = 6;
                          const int unitPrice = 700;

                          final selectedSongIds = selectedIndexes
                              .map((index) => state is GetMusicSuccess
                              ? state.englishSongs[index].id
                              : null)
                              .whereType<int>()
                              .toList();

                          final List<Map<String, dynamic>> customSongs = [];

                          cubit.reservationSonger(
                            reservationId: reservationId,
                            coordinatorId: coordinatorId,
                            serviceId: serviceId,
                            unitPrice: unitPrice,
                            songIds: selectedSongIds,
                            customSongs: customSongs,
                          );
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.blue,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  width: 300,
                                  height: 400,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "أدخل معلومات الأغنية:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(height: 20),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: "المغني",
                                          border: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.pink, width: 2),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: "اسم الأغنية",
                                          border: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.pink, width: 2),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        color: Colors.black,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "موافق",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "أريد أغنية غير موجودة",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is ReservSongerLoading ||
                  state is ReservSongerSuccess ||
                  state is ReservPhotographerFailure) {
                // لا تعرض شيء في الخلفية أثناء الحجز
                return const SizedBox.shrink();
              } else {
                return const Center(
                  child: Text(
                    "لم يتم تحميل البيانات بعد.",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
