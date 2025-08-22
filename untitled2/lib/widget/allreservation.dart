

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Api/dio_consumer.dart';
import '../cubit/getreservation_cubit.dart';
import '../cubit/getreservation_state.dart';
import '../models/getreservation_model.dart';
import 'allreservations2.dart';


// New widget to display a single service item
class ServiceDetailsWidget extends StatelessWidget {
  final Service service;

  const ServiceDetailsWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${service.serviceNameEn}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF1E88E5),
              ),
            ),
            const SizedBox(height: 8),
            Text('الكمية: ${service.quantity}',
                style: const TextStyle(fontSize: 16)),
            Text('سعر الوحدة: ${service.unitPrice}\$',
                style: const TextStyle(fontSize: 16)),
            Text(
              'السعر الإجمالي للصنف: ${service.totalItemPrice}\$',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

// New page to display the list of services
class ServicesListPage extends StatelessWidget {
  final List<Service> services;

  const ServicesListPage({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الخدمات', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: services.isEmpty
          ? const Center(
        child: Text(
          'لا توجد خدمات متاحة لهذا الحجز.',
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ServiceDetailsWidget(service: services[index]);
        },
      ),
    );
  }
}

class AllGetreservation extends StatelessWidget {
  const AllGetreservation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetReservationCubit(DioConsumer(dio:Dio()))..getReserv(),
      child: BlocConsumer<GetReservationCubit, GetReservationSatuts>(
        listener: (context, status) {},
        builder: (context, status) {
          var cubit = GetReservationCubit.get(context);
          if (status is start_GetReservationSatuts) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (cubit.getreserv == null) {
            return  Scaffold(
              appBar: AppBar(
                title: Text('ملخص الحجز', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.blue,
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const  Center(
                  child: Text('لا توجد حجوزات متاحة حالياً.'),
                              ),
                              Spacer(),
                              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50, // Customize height
                    child: ElevatedButton(
                      onPressed: () {

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Allreservations2()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'انتقل إلى كل الحجوزات',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                              ),
                            ], ),
                ),
              )

          );
          } else {
            return Scaffold(
              backgroundColor: Colors.grey[100],
              appBar: AppBar(
                title: const Text('ملخص الحجز', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.blue[900],
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'تفاصيل الحجز',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E88E5), // لون أزرق جذاب
                                  ),
                                ),
                                const Divider(height: 30),

                                // عنصر لعرض رقم الحجز
                                _buildDetailRow(
                                  label: 'رقم الحجز:',
                                  value: '${cubit.getreserv!.reservationid}',
                                  icon: Icons.confirmation_number,
                                ),
                                _buildDetailRow(
                                  label: 'التاريخ:',
                                  value: cubit.getreserv!.reservationdate.substring(0, 10), // تنسيق التاريخ
                                  icon: Icons.calendar_today,
                                ),
                                _buildDetailRow(
                                  label: 'وقت البدء:',
                                  value: cubit.getreserv!.starttime,
                                  icon: Icons.access_time,
                                ),
                                // New End Time row
                                _buildDetailRow(
                                  label: 'وقت الانتهاء:',
                                  value: cubit.getreserv!.endtime,
                                  icon: Icons.access_time,
                                ),
                                _buildDetailRow(
                                  label: 'القاعة:',
                                  value: cubit.getreserv!.hallnameen,
                                  icon: Icons.meeting_room,
                                ),
                                const Divider(height: 30),

                                // عنصر لعرض السعر الإجمالي بشكل مميز
                                _buildPriceRow(
                                  label: 'السعر الإجمالي:',
                                  value: '${cubit.getreserv!.price} ر.س',
                                  icon: Icons.monetization_on,
                                ),
                                const Divider(height: 5),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        bool success = await cubit.confirmReserv(cubit.getreserv!.reservationid);
                                        if (success) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext dialogContext) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                backgroundColor: Colors.white,
                                                title: const Text(
                                                  'تم تأكيد الحجز بنجاح!',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: const Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      'يمكنك الغاء الحجز خلال 24 ساعة فقط',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(dialogContext).pop();
                                                    },
                                                    child: const Text(
                                                      'موافق',
                                                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext dialogContext) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                backgroundColor: Colors.white,
                                                title: const Text(
                                                  'فشل الحجز !',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Icon(Icons.sms_failed, color: Colors.red, size: 60),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      '${cubit.ErrorMassege}',
                                                      textAlign: TextAlign.center,
                                                      style: const TextStyle(fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(dialogContext).pop();
                                                    },
                                                    child: const Text(
                                                      'موافق',
                                                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: const Text('confirm'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ServicesListPage(
                                            services: cubit.getreserv!.services,
                                          ),
                                        ));
                                      },
                                      child: const Text('تفاصيل الخدمات'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // New fixed button at the bottom
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50, // Customize height
                      child: ElevatedButton(
                        onPressed: () {

                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Allreservations2()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'انتقل إلى كل الحجوزات',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }


  Widget _buildDetailRow({required String label, required String value, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue[600], size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPriceRow({required String label, required String value, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green[700], size: 24),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}