import 'package:flutter/material.dart';

import 'choose_type_of_decoration.dart';
import 'choose_type_of_food.dart';

class servicesmodel{
 final String nameOfServices;
 final  IconData IconofServices;

  servicesmodel(this.nameOfServices, this.IconofServices);

}

class ChooseServices extends StatelessWidget {
   ChooseServices({super.key});
  List<servicesmodel> modelofsevices=[
   servicesmodel('Photography Services', Icons.video_camera_front_outlined) ,
    servicesmodel('Dj/Music', Icons.music_video_outlined) ,
    servicesmodel('Gifting', Icons.card_giftcard_outlined) ,
    servicesmodel('Service Staff', Icons.person) ,
    servicesmodel('Decor', Icons.deck_outlined) ,
    servicesmodel('Catering', Icons.fastfood_outlined) ,
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(
       backgroundColor: Color(0xfffdb1a1),
     ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Row(
               children: [
                 Icon(Icons.ac_unit,
                   color: Colors.blue[800],
                    size: 30,
                 ),
                 SizedBox(
                   width: 10,
                 ),
                 Text('Services', style: TextStyle(
                   fontWeight: FontWeight.bold,
                   color: Colors.blue[800],
                   fontSize: 35,
                   fontStyle: FontStyle.italic,),),
               ],
             ),
              SizedBox(
                height:5 ,),
              Text(
                'You might need ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                  fontSize: 23,
                  fontStyle: FontStyle.italic,
                ) ,),
              SizedBox(
                height:20 ,),
             GridView.count(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
                 mainAxisSpacing: 10,
               crossAxisSpacing: 10,
                 crossAxisCount: 2,
                        children: List.generate(
                          modelofsevices.length
                        ,
                            (index)=> thecontin(context,index)
                        )),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Make Your Event Special',style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold
                  ),),
                  Icon(Icons.spa_outlined)
                ],
              ),

            ]),
        )
        ),
    ),
    );
  }
  Widget thecontin( BuildContext context,int index){

    return Container(
      height: 160,
        width: 210,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: BorderDirectional(
            top: BorderSide(color: Color(0xfffdb1a1),width: 2),
            bottom:  BorderSide(color: Color(0xfffdb1a1),width: 2),
            start:  BorderSide(color: Color(0xfffdb1a1),width: 2),
            end:  BorderSide(color: Color(0xfffdb1a1),width: 2),
          ),
          color: Colors.blue[200],

        ),
        child: GestureDetector(
          onTap: (){
            if(index==0){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseTypeOfDecoration(serviceId: index,)));
            }
            if(index==5){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseTypeOfFood(servicesid: index,)));
            }
          },
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(modelofsevices[index].IconofServices,size: 50,),
              SizedBox(
                height: 10,
              ),
              Text(
                '${modelofsevices[index].nameOfServices}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),

              )
            ],
          ),
        )
    );
  }
}