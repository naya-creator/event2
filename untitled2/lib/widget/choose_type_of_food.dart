import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/dio_consumer.dart';
import '../cubit/foodcategories_cubit.dart';
import '../cubit/foodcategories_state.dart';
import 'details_of_food.dart';

class model {
  final String name;

  model(this.name);

}
class ChooseTypeOfFood extends StatelessWidget {
   int servieceId=0;
   ChooseTypeOfFood({super.key, required this.servicesid}){
   servieceId=servicesid;
   }
   final int servicesid;
List<model>modell=[
  model('Drinks'),
  model('Main meal'),
  model('Deserts'),
  model('Cake'),
];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>FoodCategories_cubit(DioConsumer(dio:Dio()))..getFoodCategories(servieceId),
    child:  BlocConsumer<FoodCategories_cubit,FoodCategories_status>
        ( listener: (BuildContext context,FoodCategories_status status){},builder: (BuildContext context, FoodCategories_status status){
      var   categories= FoodCategories_cubit.get(context).foodCategories;
          if(status is start_FoodCateoeries){
            return  Scaffold(
                appBar: AppBar(
                backgroundColor: const Color(0xfffdb1a1),

      ),
                  body:const Center(
      child:  CircularProgressIndicator(color: Color(0xfffdb1a1),),
      ));
          }

          else{
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xfffdb1a1),

            ),
            body:Padding(
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
                            border: const BorderDirectional(
                              top: BorderSide(color: Colors.blue,width:2 ),
                              bottom: BorderSide(color: Colors.blue,width:2 ),
                              start: BorderSide(color: Colors.blue,width:2 ),
                              end:  BorderSide(color: Colors.blue,width:2 ),

                            ),

                          ),
                          child:
                          const Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.keyboard_arrow_down_outlined),
                              SizedBox(
                                width: 2,
                              ),
                              Text('Food',style: TextStyle(
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
                    categories.isNotEmpty?
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      children: List.generate(categories.length

                          , (index)=>
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsOfFood(IdCategorieOfFood: categories[index].idCategoriesFood,Foodnameofcategoie: categories[index].nameEn,)));
                                  },
                                  child: Container(
                                    width: 220,
                                    height: 200,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[200]
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          width: 200 ,
                                          height: 150,
                                    /*      child:    Image.network("${EndPoints.imageUrl22}${categories[index].image}",
                                            fit:    BoxFit.fill,),*/

                                          ),

                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(categories[index].nameEn,
                                          style: const TextStyle(
                                            fontWeight:FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 20,

                                          ),)

                                      ],
                                    ),
                                  )
                              )),) :
                        const Center(
                         child:  Text('لا يوجد أنواع متاحه'),
                        )

                  ],
                ),
              ),
            ),
          );}
    }),);

  }
}
