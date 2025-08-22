import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/dio_consumer.dart';
import '../cubit/decorationtype_cubit.dart';
import '../cubit/decorationtype_state.dart';
import 'details_of_type_decoration.dart';

class ChooseTypeOfDecoration extends StatelessWidget {
  int idService=0;
  
  ChooseTypeOfDecoration({super.key, required this.serviceId}){
    idService=serviceId;
   
  }
  final int serviceId;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>DecorationType_cubit(DioConsumer(dio:Dio()))..getAllDecorationTypes(idService),
    child: BlocConsumer<DecorationType_cubit,DecorationType_status>
      (listener:(context,status){}, builder:(context,status){
        var key2= DecorationType_cubit.get(context);
        if(status is start_DecorationType_status){
          return   Scaffold(
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
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: List.generate(key2.allDecorationType.length

                        , (index)=>

                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsOfTypeDecoration(decorationId: key2.allDecorationType[index].TypeId,decorationName:key2.allDecorationType[index].nameEn ,)));
                              },
                              child: Stack(
                                  children: [Container(
                                    width: 160,
                                    height: 160,

                                    decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: BorderRadius.circular(100),

                                    ),

                                  ),
                                     Column(
                                      children: [
                                        const Expanded(
                                          child: CircleAvatar(

                                            backgroundImage: AssetImage(
                                                'assets/images/shopping.webp'
                                            ),
                                            backgroundColor: Colors.indigo,
                                            radius:300,


                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            key2.allDecorationType[index].nameEn,
                                            style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )
                                        )
                                      ],
                                    ),
                                  ]  ),
                            )),)

                ],
              ),
            ),
          )

      );}
    } ),
    
    );
  }
}
