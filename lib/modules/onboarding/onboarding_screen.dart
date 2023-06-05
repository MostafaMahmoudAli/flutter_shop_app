


import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/componants/componants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../shop_login/shop_login_screen.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}


class OnBoardingScreen extends StatefulWidget{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<BoardingModel>boarding=[
    BoardingModel(
      image:"assets/images/onboard_1.jpg",
      title:"On Board Title 1",
      body: "On Board Body 1",
    ),
    BoardingModel(
      image:"assets/images/onboard_1.jpg",
      title:"On Board Title 2",
      body: "On Board Body 2",
    ),
    BoardingModel(
      image:"assets/images/onboard_1.jpg",
      title:"On Board Title 3",
      body: "On Board Body 3",
    ),
  ];

  var boardingController=PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        actions:[
          defultTextButton(
              function:()=>submit(context),
              text: 'Skip',
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:[
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if(index==boarding.length-1)
                  {
                    setState(() {
                      isLast=true;
                    });
                    print('last');
                  }else
                  {
                    setState((){
                      isLast=false;
                    });
                  }
                },
                physics:const BouncingScrollPhysics(),
                controller:boardingController,
                itemBuilder:(context,index)=>defultBoardingItem(boarding[index]),
                itemCount:boarding.length,
              ),
            ),
            const SizedBox(
              height:40.0,
            ),
            Row(
              children:[
                SmoothPageIndicator(
                  controller:boardingController,
                  count:boarding.length,
                  effect:ExpandingDotsEffect(
                    activeDotColor:primarySwitchColor,
                    dotHeight:10.0,
                    dotWidth: 10.0,
                    spacing:5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed:()
                  {
                    if(isLast)
                    {
                      submit(context);
                    }else
                    {
                      boardingController.nextPage(
                        duration:const Duration(
                          milliseconds:750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }

                  },
                  child:const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}

 submit(BuildContext context)
{
  print('print yesssss');
  CacheHelper.saveData(key: "onBoarding",value:true).then((value)
  {
    if(value)
    {
      navigateAndFinish(context,ShopLoginScreen());
    }
  });
  print(CacheHelper.getData(key:"onBoarding"));


}


 Widget defultBoardingItem(BoardingModel model)=>Column(
   crossAxisAlignment:CrossAxisAlignment.start,
   children: [
     Expanded(
       child: Image(
         image:AssetImage(model.image),
       ),
     ),
     const SizedBox(
       height:30.0,
     ),
     Text(
       model.title,
       style:const TextStyle(
         fontSize:25.0,
       ),
     ),
     const SizedBox(
       height:15.0,
     ),
     Text(
       model.body,
       style:const TextStyle(
         fontSize:15.0,
       ),
     ),
   ],
 );


