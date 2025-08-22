import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/dio_consumer.dart';
import '../cubit/fooddetails_cubit.dart';
import '../cubit/fooddetails_state.dart';
import '../models/fooddetails_model.dart';


class DetailsOfTypeFood extends StatelessWidget {
  final int Foodid;
  final String Gategorename;

  const DetailsOfTypeFood({super.key, required this.Foodid, required this.Gategorename});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodDetails_Cubit(DioConsumer(dio:Dio()))..getAllFoodDetails(Foodid),
      child: BlocConsumer<FoodDetails_Cubit, FoodDetails_Status>(
        listener: (context, status) {},
        builder: (context, status) {
          List<FoodDetailsModel> listFood = FoodDetails_Cubit.get(context).allFoodDetails;

          if (status is start_FoodDetails_Status) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xfffdb1a1),
              ),
              body: const Center(
                child: CircularProgressIndicator(color: Color(0xfffdb1a1)),
              ),
            );
          }

          if (listFood.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xfffdb1a1),
              ),
              body: const Center(
                child: Text("لا توجد عناصر متاحة حالياً"),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xfffdb1a1),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.blue, width: 2),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  const Icon(Icons.keyboard_arrow_down_outlined),
                                  const SizedBox(width: 2),
                                  Expanded(
                                    child: Text(
                                      Gategorename,
                                      style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final foodItem = listFood[index];
                          return FoodItemCard(foodItem: foodItem,foodID: Foodid,);
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemCount: listFood.length,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}


class FoodItemCard extends StatelessWidget {
  final FoodDetailsModel foodItem;
  final int foodID;

  const FoodItemCard({super.key, required this.foodItem, required this.foodID});


  void _showQuantityDialog(BuildContext context) {
    final quantityController = TextEditingController();
    final reservationId = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'حدد الكمية',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'الكمية المطلوبة',
                    labelStyle: TextStyle(color: Color(0xfffdb1a1)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfffdb1a1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: reservationId,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'ادخل رقم حجزك',
                    labelStyle: TextStyle(color: Color(0xfffdb1a1)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfffdb1a1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'إلغاء',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            TextButton(
              onPressed: () async{
                final String quantity = quantityController.text;
                final String reservid= reservationId.text;
                try {
                  int quantityAsInt = int.parse(quantity);
                  int reservAsInt = int.parse(quantity);
                  print('The address as an integer is: $quantityAsInt');
                } catch (e) {
                  print('Failed to convert address to integer: $e');
                }
                if (quantity.isNotEmpty) {

                final cubit =FoodDetails_Cubit.get(context);

                // Call the reservation function
                bool success = await cubit.AddFoodtoReseve(int.parse(reservationId.text), foodID,int.parse(quantity));

                // Show a SnackBar based on the result
                if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                content: Center(child: Text('تم اضافه المنتج للحجز')),
                backgroundColor: Colors.green,
                ),
                );
                } else {
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                content: Center(child: Text('فشل باضافه المنتج للحجز${cubit.errormessage}')),
                backgroundColor: Colors.red,
                ),
                );
                }
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text(
                'تأكيد',
                style: TextStyle(color: Color(0xfffdb1a1), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 200,
            width: 350,
            child: Image(
              image: const AssetImage("assets/images/images.jpg"),
              fit: BoxFit.fill,
              errorBuilder:
                  (context, error, stackTrace) {
                return const Icon(Icons.broken_image,
                    size: 50);
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                'السعر: ${foodItem.Price}\$',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Spacer(),
              Text(
                foodItem.nameEn,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _showQuantityDialog(context);
                },
                child: const Text(
                  'شراء',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
