import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/dio_consumer.dart';
import '../cubit/getallreservation_cubit.dart';
import '../cubit/getallreservation_state.dart';
import '../models/getallreservation_model.dart';


class Allreservations2 extends StatelessWidget {
  const Allreservations2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'حجوزاتي',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      home: BlocProvider(
        create: (context) => GetallreservationCubit(DioConsumer(dio:Dio()))..getAllReservation(),
        child: const ReservationsScreen(),
      ),
    );
  }
}

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حجوزاتي', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: BlocConsumer<GetallreservationCubit, GetallreservationStatus>(
        listener: (context, state) {
          if (state is finish_DeletereservationStatus) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إلغاء الحجز بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is error_DeletereservationStatus) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('خطأ في إلغاء الحجز: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is start_GetallreservationStatus) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is error_GetallreservationStatus) {
            return Center(child: Text('خطأ: ${state.error}'));
          } else if (state is finish_GetallreservationStatus ||
              state is finish_DeletereservationStatus) {
            final reservations = context.read<GetallreservationCubit>().allReservation;
            if (reservations.isEmpty) {
              return const Center(child: Text('لا توجد حجوزات حالياً.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final reservation = reservations[index];
                return ReservationCard(reservation: reservation);
              },
            );
          }
          return const Center(child: Text('انتظر رجاء'));
        },
      ),
    );
  }
}

class ReservationCard extends StatelessWidget {
  final GetallreservationModel reservation;

  const ReservationCard({required this.reservation, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${reservation.hallNameAr}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const Divider(height: 16),
            buildInfoRow('تاريخ الحجز:', reservation.reservationDate.split('T').first),
            buildInfoRow('وقت الحجز:', '${reservation.startTime} - ${reservation.endTime}'),
            buildInfoRow('السعر الإجمالي:', '${reservation.totalPrice} ريال'),
            buildInfoRow('القدرة الاستيعابية:', '${reservation.capacity} شخص'),
            buildInfoRow('الموقع:', reservation.locationAr),
            if (reservation.services.isNotEmpty) ...[
              const Divider(height: 16),
              const Text(
                'الخدمات:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ...reservation.services.map((service) => Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                child: Text('- ${service.nameAr} (${service.quantity})'),
              )),
            ],
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // استدعاء تابع الحذف من الـ Cubit
                  // Calling the delete method from the Cubit
                  context
                      .read<GetallreservationCubit>()
                      .deleteReservation(reservation.reservId);
                },
                icon: const Icon(Icons.delete, color: Colors.white),
                label: const Text(
                  'إلغاء الحجز',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
