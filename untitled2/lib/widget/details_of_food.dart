import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Api/dio_consumer.dart';
import '../Api/endpoint.dart';
import '../cubit/foodtype_cubit.dart';
import '../cubit/foodtype_state.dart';
import 'details_of_type_food.dart';

class DetailsOfFood extends StatelessWidget {
  String categoieFoodName='S';
 int categoieFood=0;
   DetailsOfFood({super.key, required this.IdCategorieOfFood, required this.Foodnameofcategoie}){
    categoieFood=IdCategorieOfFood;
    categoieFoodName=Foodnameofcategoie;
  }
  final int IdCategorieOfFood;
 final  String Foodnameofcategoie;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>FoodType_Cubit(DioConsumer(dio:Dio()))..getAllFoodTypes(categoieFood),
    child: BlocConsumer<FoodType_Cubit,FoodType_status>
      ( listener:(BuildContext context , FoodType_status status){},builder: (BuildContext context, FoodType_status status){
   var key1=  FoodType_Cubit.get(context);
        if(status is start_FoodType_Status){
          return   Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xfffdb1a1),
              ),
          body: const Center(
            child: CircularProgressIndicator(color: Color(0xfffdb1a1),)
            ),
          );
        }
        else{
        return Scaffold(
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
                            Flexible(
                              child: Text(categoieFoodName,style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              
                              
                              ) ,
                              overflow:TextOverflow.ellipsis ,),
                            ),
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
                              child:    Image.network(
                                "${Endpoint.imageUrl}${FoodType_Cubit.get(context).allFoodTypes[index].image}", fit: BoxFit.fill,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image,
                                      size: 50);
                                },),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                const Spacer(),
                                Text(
                                  FoodType_Cubit.get(context).allFoodTypes[index].nameEn
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
                                IconButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsOfTypeFood(Foodid:key1.allFoodTypes[index].foodvariants, Gategorename: key1.allFoodTypes[index].nameEn,),));
                                    },
                                    icon:const Icon(Icons.arrow_circle_left_outlined,size: 30,) ),

                              ],
                            )
                          ],
                        ),

                      ) ,
                      separatorBuilder: (context,index)=>const SizedBox(
                        height: 10,
                      ) ,
                      itemCount: FoodType_Cubit.get(context).allFoodTypes.length)
                ],
              ),
            ),
          ),
        );}
    }),
        );
  }
}
