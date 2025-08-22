
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';


class Amusic extends StatefulWidget {
  const Amusic({Key? key}) : super(key: key);

  @override
  State<Amusic> createState() => _AmusicState();
}

class _AmusicState extends State<Amusic> {
  Set<int> selectedIndexes = {};
  TextEditingController song = TextEditingController();
  TextEditingController singer = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
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
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          Positioned.fill(
            top: 100,
            left: 20,
            right: 20,
            bottom: 20,
            child: BlocConsumer<UserCubit, UserState2>(
              listener: (context, state) {
                if (state is GetMusicFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }

                if (state is addSongLoading || state is ReservSongerLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                  );
                }

                // فقط عند النجاح أو الفشل نغلق الـ loading dialog
                if (state is addSongSuccess ||
                    state is ReservSongerSuccess ||
                    state is addSongFailure ||
                    state is ReservSongerFailure) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context); // يغلق loading dialog فقط
                  }

                  if (state is addSongSuccess || state is ReservSongerSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("تم الحجز بنجاح")),
                    );
                    context.read<UserCubit>().getMusic();
                  }

                  if (state is addSongFailure || state is ReservSongerFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("فشل الحجز")),
                    );
                    context.read<UserCubit>().getMusic();
                  }
                }
              },
              builder: (context, state) {
                if (state is GetMusicLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetMusicSuccess) {
                  final arabicSongList = state.arabicSongs;

                  if (arabicSongList.isEmpty) {
                    return const Center(
                      child: Text("لا توجد أغانٍ عربية حالياً",
                          style: TextStyle(color: Colors.white)),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "اختر الأغاني العربية",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: arabicSongList.length,
                          itemBuilder: (context, i) {
                            final song = arabicSongList[i];
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
                      const SizedBox(height: 20),
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
                              ? state.arabicSongs[index].id
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
                        child: const Text(
                          "تأكيد",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "أدخل معلومات الأغنية:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(height: 20),
                                      TextField(
                                        controller: singer,
                                        decoration: InputDecoration(
                                          hintText: "المغني",
                                          border: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.pink, width: 2),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: song,
                                        decoration: InputDecoration(
                                          hintText: "اسم الأغنية",
                                          border: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.pink, width: 2),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        color: Colors.black,
                                        onPressed: () {
                                          if (song.text.isEmpty ||
                                              singer.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "يرجى ملء جميع الحقول")),
                                            );
                                            return;
                                          }

                                          Navigator.pop(context);
                                          context.read<UserCubit>().addSong();
                                        },
                                        child: const Text(
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
                        child: const Text(
                          "أريد أغنية غير موجودة",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                } else if (state is ReservSongerLoading ||
                    state is ReservSongerSuccess ||
                    state is ReservPhotographerFailure ||
                    state is addSongLoading ||
                    state is addSongSuccess ||
                    state is addSongFailure) {
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
