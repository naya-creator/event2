import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Api/dio_consumer.dart';
import '../Api/endpoint.dart';
import '../cubit/detailsofdecorationtype_cubit.dart';
import '../cubit/detailsofdecorationtype_state.dart';

class DetailsOfTypeDecoration extends StatelessWidget {
  int  IdDecoration=0;
  String NameDecoration='ad';
  DetailsOfTypeDecoration({super.key, required this.decorationId, required this.decorationName}){
    IdDecoration=decorationId;
    NameDecoration=decorationName;
  }
  final int decorationId;
  final String decorationName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>DetailsOfDecorationType_cubit(DioConsumer(dio:Dio()))..getAllDetailsofdecorationtypes(IdDecoration),
    child: BlocConsumer<DetailsOfDecorationType_cubit,DetailsOfDecorationType_status>
      (listener:(context,status){}, builder: (context,status){
      var key1=DetailsOfDecorationType_cubit.get(context);
      var quantity= TextEditingController();
      void _showQuantityDialog(BuildContext context,String color ,String price) {
        final quantityController = TextEditingController();
        final reservationId = TextEditingController();
        final locationcontroller = TextEditingController();

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
                height: 250,
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: locationcontroller,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'ادخل الموقع الزينه ',
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

                      final cubit =DetailsOfDecorationType_cubit.get(context);

                      // Call the reservation function
                      bool success = await cubit.AddDecoretoReseve(int.parse(reservationId.text), decorationId,locationcontroller.text,color,int.parse(quantity),double.parse(price));

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
      if(status is start_DetailsOfDecorationType_status){

        return  Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xfffdb1a1),

            ),
            body:const Center(
              child:  CircularProgressIndicator(color: Color(0xfffdb1a1),),
            ));
      }
      else{
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xfffdb1a1),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:SingleChildScrollView(
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
                          border: const BorderDirectional(
                            top: BorderSide(color: Colors.blue,width:2 ),
                            bottom: BorderSide(color: Colors.blue,width:2 ),
                            start: BorderSide(color: Colors.blue,width:2 ),
                            end:  BorderSide(color: Colors.blue,width:2 ),

                          ),

                        ),
                        child:
                         Center(child: Row(

                          children: [
                            const Icon(Icons.keyboard_arrow_down_outlined),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(decorationName,style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,

                            ) ,),
                          ],
                        ),),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder:(context,index)=>

                          Container(
                        color: Colors.grey[200],

                        child: Column(
                          children: [
                            const SizedBox(
                                height:  5
                            ),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              height:200 ,
                              width:350,
                              child:
                              Image.network(
                                '${Endpoint.imageUrl}${key1.alldetailsofdecoartion[index].Image}',
                                height: 200,
                                fit: BoxFit.cover,
                                // معالج الأخطاء في حالة فشل تحميل الصورة
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Price:${key1.alldetailsofdecoartion[index].price}'
                                  ,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  key1.alldetailsofdecoartion[index].nameEn
                                  ,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: (){
                                _showQuantityDialog(context,key1.alldetailsofdecoartion[index].color,key1.alldetailsofdecoartion[index].price);
                                   //   Navigator.push(context, MaterialPageRoute(builder: (context)=>const PlacesOfTypes()));

                                    },
                                    child:Text('Buy',style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),),),
                                const Spacer(),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    width: double.maxFinite,

                                    child:  Center(
                                      child: Text(key1.alldetailsofdecoartion[index].color,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),),
                                    ),
                                  ),
                                ) ,

                                const SizedBox(
                                  width:15,
                                )


                              ],
                            )
                          ],
                        ),

                      ) ,
                      separatorBuilder: (context,index)=>const SizedBox(
                        height: 10,
                      ) ,
                      itemCount: key1.alldetailsofdecoartion.length)
                ],
              ),
            ),
          ),
        );
      }
    }),
    );
  }

}

