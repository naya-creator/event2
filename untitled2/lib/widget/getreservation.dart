import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/dio_consumer.dart';
import '../cubit/getreservation_cubit.dart';
import '../cubit/getreservation_state.dart';


class Getreservation extends StatelessWidget {
  const Getreservation({super.key});




  @override
  Widget build(BuildContext context) {



  return  BlocProvider(create: (context)=>GetReservationCubit(DioConsumer(dio:Dio()))..getReserv(),
  child:  BlocConsumer<GetReservationCubit,GetReservationSatuts>
    ( listener: (context,status){}, builder: (context , status){
      var cubit = GetReservationCubit.get(context);
      if(status is start_GetReservationSatuts){
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

   else{
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text('ملخص الحجز', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.blue[900],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
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
                        value:'${ cubit.getreserv!.reservationid}',
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
                      _buildDetailRow(
                        label: 'القاعة:',
                        value:cubit.getreserv!.hallnameen,
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
                      TextButton(onPressed: (){
                       cubit.confirmReserv(cubit.getreserv!.reservationid);

                      }, child: const Text('confirm'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
  }  ),);
  }

  // دالة مساعدة لبناء صف من التفاصيل
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
