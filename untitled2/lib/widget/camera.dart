
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/dio_consumer.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';


class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
 /* void initState() {
    super.initState();
    context.read<UserCubit>().getPhotographer(); // استدعاء API المصورين
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>UserCubit(DioConsumer(dio:Dio()))..getPhotographer(),
    child: Scaffold(
      body: Container(
        height: double.infinity,
      /* decoration:
        BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/images.jpg"),
            fit: BoxFit.cover,

          ),
        ),*/
        child: Column(
          children: [
            // زر الرجوع
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: BlocConsumer<UserCubit, UserState2>(
                  listener: (context, state) {
                    if (state is GetPhotoFaliure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }

                    if (state is ReservPhotographerLoading) {
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

                    if (state is ReservPhotographerSuccess) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("تم الحجز بنجاح")),
                      );
                      context.read<UserCubit>().getPhotographer();
                    }

                    if (state is ReservPhotographerFailure) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("فشل الحجز")),
                      );
                      context.read<UserCubit>().getPhotographer();
                    }
                  },
                  builder: (context, state) {
                    if (state is GetPhotoLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetPhotoSuccess) {
                      final photosList = state.photos;

                      if (photosList.isEmpty) {
                        return const Center(
                          child: Text(
                            "لا توجد مصورين حالياً",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return GridView.builder(
                        itemCount: photosList.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 3.0,
                        ),
                        itemBuilder: (context, i) {
                          final photoo = photosList[i];

                          return InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      width: 300,
                                      height: 100,
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 10),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);

                                              context
                                                  .read<UserCubit>()
                                                  .reservationPhotographer(
                                                reservationId: 10,
                                                coordinatorId:
                                                photoo.user.id,
                                                serviceId: 2,
                                                unitPrice: 500,
                                              );
                                            },
                                            child: const Card(
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  "Revers",
                                                  textAlign: TextAlign.center,
                                                ),
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
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    photoo.user.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is ReservPhotographerLoading ||
                        state is ReservPhotographerSuccess ||
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
