import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bottom_navigation_bar_cubit.dart';
import '../cubit/bottom_navigation_bar_status.dart';


class PlacesOfTypes extends StatelessWidget {
   const PlacesOfTypes({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>cubit_bottom_navigation_bar(),
      child: BlocConsumer<cubit_bottom_navigation_bar,Status_bottom_navigation_bar>(
        listener: (context,Status_bottom_navigation_bar status){},
        builder: (context,Status_bottom_navigation_bar status){

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: (){

                },
                    icon: const Icon(Icons.list_outlined,size: 30,color: Colors.black,))
              ],
              backgroundColor: const Color(0xfffdb1a1),
            ),
            body:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [


                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index) =>mycolumn(context),
                        itemCount: 15,
                        separatorBuilder: (context,index)=> const SizedBox(
                          height: 5,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ) ,
          );
        },
      )


    );
  }
}

Widget mycolumn (BuildContext context){



  return  Container(
    width: double.infinity,

    color: Colors.white60,
    child: Column(

      children: [
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: (){

          },
          child: Container(

             height: 270,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white60
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: const Image(
                image: AssetImage(
              "assets/images/shopping.webp",

            ),

           fit: BoxFit.fill       ),

          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 40,
            ),
            const Text("on tabels",
              style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              fontWeight: FontWeight.bold,)),
           const Spacer(),
            IconButton(
                onPressed: (){
                cubit_bottom_navigation_bar.get(context).function_changeFromAddIconToAddedSuccessfully();
            },
                icon: cubit_bottom_navigation_bar.get(context).changeFromAddIconToAddedSuccessfully?  const Icon(Icons.offline_pin_outlined,color: Colors.deepOrange,size: 30,):const Icon(Icons.add_box,color: Colors.deepOrange,size: 30,),),
            const SizedBox(
              width: 40,
            )
          ],
        ),

      ],
    ),
  );
}