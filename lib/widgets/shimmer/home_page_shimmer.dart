import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class HomePageShimmer extends StatefulWidget {
  const HomePageShimmer({super.key});

  @override
  _HomePageShimmerState createState() => _HomePageShimmerState();
}

class _HomePageShimmerState extends State<HomePageShimmer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index)=>Container(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical:2.5),
        width: SizeConfig.screenWidth,
        //height: SizeConfig.screenHeight!/3.5,
        child: Card(

            elevation: 1,
            // shadowColor: Colors.blueGrey,

            shape: const RoundedRectangleBorder(

              borderRadius: BorderRadius.all(Radius.circular(5)),
              side: BorderSide(
                width: 0.05,


              ),
            ),

            child:Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                              child: const Icon(Icons.access_time)
                          ),
                          const SizedBox(width: 10,),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            child: const Text(
                                '12 hours',
                              style: TextStyle(color: Colors.transparent),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center ,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                              child: Container(
                                padding: const EdgeInsets.only(right: 5),
                                height:30 ,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    //  elevation: 0.0,
                                    backgroundColor: Colors.transparent, // background
                                    // foreground
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // <-- Radius
                                    ),
                                  ),

                                  onPressed: (){},
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: const Text(
                                      'Accept',
                                      style: TextStyle(color: Colors.transparent,


                                      ),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                              child: SizedBox(
                                height:30 ,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    //  elevation: 0.0,
                                    backgroundColor: Colors.transparent,  // background
                                    foregroundColor: Colors.white, // foreground
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // <-- Radius
                                    ),
                                  ),

                                  onPressed: (){},
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: const Text(
                                      'Reject',
                                      style: TextStyle(color: Colors.transparent,

                                      ),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          ],),
                      )

                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical:1),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 5,right: 5),
                    child: Row(children: [


                      //order id
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[400]!,
                        child: const Text("Order Id: #",style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                             color: Colors.transparent
                        ),),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[400]!,
                        child: const Text('#39',style: TextStyle(
                          color: Colors.transparent,
                          fontSize:FontSize.xMedium,
                        ),),
                      ),
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                    child: Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                          child: const Text("Time: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.transparent
                            ),),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                          child: const Text('12-12-2021',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              //fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.transparent,
                              fontFamily: 'AirbnbCerealBold',
                            ),),
                        ),



                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),



                    child: Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                          child: const Text("Payment mode: ",
                            style: TextStyle(

                              fontWeight: FontWeight.w400,

                              fontSize:16,
                              color: Colors.transparent
                            ),),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                          child: const Text('Stripe',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              // fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.transparent,
                              fontFamily: 'AirbnbCerealBold',
                            ),),
                        ),



                      ],
                    ),


                  ),
                  const SizedBox(height:10,)





                ],
              ),
            )
        )),);
  }
}
