import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login.dart';

class model{
 final String image ;
 final String text1;
 final String text2;

  model(this.image, this.text1, this.text2);

}
class Onbording extends StatelessWidget {

List<model> onbordingmodels=[

  model("assets/images/flat-food-poster-template_23-2149046595.jpg", " Welcome To Our Application", "Safety Food "),
  model("assets/images/flat-food-badges-collection_23-2149046599.jpg", "You Stay At Home", "We Deliver"),
  model("assets/images/flat-fast-food-webinar_23-2149046598.jpg", "AnyWhere Or AnyTime", "Order Now"),
];

  Onbording({super.key});
  @override
  Widget build(BuildContext context) {

    var onbordingContoller = PageController();
    bool islod = false;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.indigo[900],
        backgroundColor: Colors.deepOrange,

      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           TextButton(onPressed: (){
             Navigator.pushAndRemoveUntil(context,
                 MaterialPageRoute(builder: (context)=> Login()),
                     (Route<dynamic> route)=> false
             );
           }, child: const Text('Skip',style: TextStyle(
           fontWeight: FontWeight.bold,
           fontSize: 20,
           color: Colors.deepOrange,
           ),)),
            Expanded
              (child:
            PageView.builder(
              controller: onbordingContoller,
                onPageChanged: (int index){
                if(index==onbordingmodels.length-1){
                  islod=true;
                }
                else{
                  islod=false;
                }
                },
                itemBuilder:(context,index)=>onbording_screens(onbordingmodels[index]),
            itemCount: onbordingmodels.length,
            ),
                    ),

         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             const SizedBox(
               width: 20,
             ),
             SmoothPageIndicator(
                 controller: onbordingContoller,
                 effect: const ExpandingDotsEffect(
                   activeDotColor: Colors.deepOrange,
                 dotWidth: 14,
                   dotHeight: 10,
                 ) ,
                 count: 3),
             const Spacer(),
             FloatingActionButton(backgroundColor: Colors.deepOrange,
               onPressed: (){
               if(islod){
                 Navigator.pushAndRemoveUntil(context,
                   MaterialPageRoute(builder: (context)=>Login()),
                     (Route<dynamic> route)=> false
                 );
             }
               else{
                 onbordingContoller.nextPage(duration: const Duration(
                     microseconds: 750
                 ), curve: Curves.ease);
               }
               },
               child: const Icon(Icons.arrow_forward,color: Colors.indigo,size: 35,),),
             const SizedBox(
               width: 15,
             )
           ],
         ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      )
    );
  }
}


Widget onbording_screens(model mod){

  return Column(
    children: [
      Image(image:
      AssetImage(
          mod.image) ),
      const SizedBox(
        height: 50,
      ),
      Row(
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            mod.text1,
            style: TextStyle(
              fontWeight:FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 25,
              color: Colors.indigo[900],

            ),),
        ],
      ),
      const SizedBox(
        height: 70,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            width: 30,
          ),
          const Icon(Icons.arrow_forward_ios_sharp,color: Colors.deepOrange,),
          const Icon(Icons.arrow_forward_ios_sharp,color: Colors.indigo,),
          const Icon(Icons.arrow_forward_ios_sharp,color: Colors.deepOrange,),
          const Icon(Icons.arrow_forward_ios_sharp,color: Colors.indigo,),
          const Spacer(),
          Text(
            mod.text2,
            style: TextStyle(
              fontWeight:FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 25,
              color: Colors.indigo[900],

            ),),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    ],
  );



}