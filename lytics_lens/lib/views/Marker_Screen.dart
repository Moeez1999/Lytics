import 'package:flutter/material.dart';
import 'package:lytics_lens/Views/Components/Global_BottmNav.dart';
import 'package:lytics_lens/Views/player_Screen.dart';
import 'package:lytics_lens/utils/commoncolor.dart';

class MarkerScreen extends StatefulWidget {
  const MarkerScreen({ Key? key }) : super(key: key);

  @override
  _MarkerScreenState createState() => _MarkerScreenState();
}

class _MarkerScreenState extends State<MarkerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(),
      bottomNavigationBar: GlobalBottomNav(),
      body: SingleChildScrollView(
        child: Container(
          // width: double.infinity,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width*0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        // color: Color.fromRGBO(90, 92, 105, 1)
                      ),
                      child: Column(
                        children: [
                          Image.asset("assets/images/image.png"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                            child: MaterialButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerScreen()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(9.0))
                              ),
                              color: Color.fromRGBO(72, 190, 235, 1),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.play_arrow,size: 30.0,color: Colors.white,),
                                    Text("PLAY",style: TextStyle(color: Colors.white,fontSize: 18.0),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width*0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color.fromRGBO(90, 92, 105, 1)
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0),
                child: Divider(color: Colors.white24,thickness: 1.0,),
              ),

              SizedBox(height: 100.0,),

              Container(
                width: 330,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromRGBO(45, 47, 58, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0,right: 5.0,left: 5.0,bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    
                    programInfoContainer(),
                    SizedBox(width: 5.0,),
                    segmentAnalysisContainer(),
                      
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


Widget segmentAnalysisContainer(){
  return Container(
                        width: 155,
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(90, 92, 105, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height:5.0),
                              Center(child: Text("Segment Analysis",style: TextStyle(fontSize: 12.0,color: Colors.white,fontWeight: FontWeight.bold),)),
                              SizedBox(height: 10.0,),
                              
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Overall Segment Analysis",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
                                 


                                SizedBox(height: 5.0,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[400],
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical:4.0,horizontal: 8.0),
                                    child: Text("Positive",style: TextStyle(color: Colors.white,fontSize: 10.0),),
                                  ),
                                ),

                                SizedBox(height: 0.0,),
                            Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Divider(
                                  thickness:3.0,
                                  color: Color.fromRGBO(45, 47, 58, 1),
                                ),
                            ),
                            SizedBox(height: 0.0,),
                            Text("Segment Anchor Particulars",style: TextStyle(color: Colors.white,fontSize: 11.0,fontWeight: FontWeight.bold)),


                            SizedBox(height: 7.0,),
                            Text("Hamid Mir",style: TextStyle(color: CommonColor.orangeColor,fontSize: 11.0)),

                            SizedBox(height: 4.0,),
                            Row(
                                children: [
                                  Text("Sentiments:  ",style: TextStyle(color: Colors.white54,fontSize: 11.0)),
                                  Card(
                                    color: Colors.blue[400],
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                                      child: Text("Balanced",style: TextStyle(fontSize: 10.0,color: Colors.white,),),
                                    ),
                                  ),
                                ],
                            ),
                            
                            SizedBox(height: 1,),
                            RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: "Scale:  ",style: TextStyle(fontSize: 11.0,color: Colors.white54)),
                                    TextSpan(text: "Normal",style: TextStyle(fontSize: 11.0,color: CommonColor.orangeColor),),
                                  ]
                                ),
                            ),
                             ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
}


  Widget programInfoContainer(){
    return Container(
                        width: 155,
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Color.fromRGBO(90, 92, 105, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height:5.0),
                              Center(child: Text("Program Info",style: TextStyle(fontSize: 12.0,color: Colors.white,fontWeight: FontWeight.bold),)),
                              SizedBox(height: 15.0,),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(text: "Clipped By:  ",style: TextStyle(color: Colors.white60,fontSize: 11.0)),
                                            TextSpan(text: "Sheikh Ali",style: TextStyle(color: CommonColor.orangeColor,fontSize: 11.0)),
                                          ],
                                        ),
                                      ),
                                  
                                


                                SizedBox(height: 10.0,),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: "QC By:  ",style: TextStyle(color: Colors.white60,fontSize: 11.0)),
                                      TextSpan(text: "Ahsan Khan",style: TextStyle(color: Colors.blue[300],fontSize: 11.0)),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 10.0,),
                            RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: "Marked By:  ",style: TextStyle(color: Colors.white60,fontSize: 11.0)),
                                    TextSpan(text: "Ghyas Salim",style: TextStyle(color: Colors.green,fontSize: 11.0)),
                                  ],
                                ),
                            ),

                            SizedBox(height: 20.0,),
                            RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: "Main Theme:  ",style: TextStyle(color: Colors.white60,fontSize: 11.0)),
                                    TextSpan(text: "1. Economy",style: TextStyle(color: CommonColor.orangeColor,fontSize: 11.0)),
                                  ],
                                ),
                            ),


                            SizedBox(height: 10.0,),
                            RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: "Sub Theme(s):  ",style: TextStyle(color: Colors.white60,fontSize: 11.0)),
                                    TextSpan(text: "1. Budget",style: TextStyle(color: CommonColor.orangeColor,fontSize: 11.0)),
                                ],
                                ),
                            ),
                            ],
                          ),
                              ),
                          ],
                              ),
                        ),
                      );
  }
}