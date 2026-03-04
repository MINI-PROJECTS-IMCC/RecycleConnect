import "package:flutter/material.dart";
import "package:http/http.dart";
import "package:flutter_svg/svg.dart";
class HomePage extends StatefulWidget{

    const HomePage({super.key});

    @override
    State<HomePage> createState()=>_Home();

}
class _Home extends State<HomePage>{
   

    @override
    Widget build(BuildContext context){
        return Scaffold(
            body:Container(
                 

                child:Column(

                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                    
                    Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color:Colors.green
                        ),
                        child:Row(
                            mainAxisSize: MainAxisSize.max,
                            
                            children: [
                            SizedBox(width:40),
                            Text("RecycleConnect.in",style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                            SizedBox(width:40),
                            Text("locations"),
                             SizedBox(width:100),
                            Center(
                                child:Container(
                                    width:500,
            
                                    child:TextField(decoration: InputDecoration(hintText: "search",border:OutlineInputBorder(borderRadius:BorderRadius.circular(20)),filled:true,fillColor: Colors.white, prefixIcon: Icon(Icons.search, color: Colors.grey)))

                                )
                            )
                        ],)


                    ),
                    SizedBox(height:20),
                    Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    
                    children:[

                    SizedBox(width:20),
                    Container(
                        width:300,
                        padding:EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:Colors.white
                        ),
                        child:Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            SizedBox(height: 70),
                            SvgPicture.asset("assets/images/profile.svg",
                            height:90,
                            width:90,
                            color:Colors.green),
                            SizedBox(height: 50),
                            
                            
                            Text("Welcome Vallabh",style:TextStyle(fontSize: 20)),
                            SizedBox(height: 30),
                            Divider(),
                            SizedBox(height: 30),
                            SizedBox(
                                width:200,
                                child:ElevatedButton(onPressed: (){
                                    print("BinBox added");
                                },
                                child:Text("Open BinBox")
                                )
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                                width:200,
                                child:ElevatedButton(onPressed: (){
                                    print("Organization show");
                                },
                                child:Text("See Organizations")
                                )
                            ),
                            SizedBox(height:30),
                            SizedBox(
                                width:200,
                                child:ElevatedButton(onPressed: (){
                                    print("History");
                                },
                                child:Text("See History")
                                )
                            ),
                            SizedBox(height:30),
                            SizedBox(
                                width:200,
                                child:ElevatedButton(onPressed: (){
                                    print("Track Order");
                                },
                                child:Text("Track Order")
                                )
                            ),
                             SizedBox(height: 30),
                             SizedBox(
                                width:200,
                                child:ElevatedButton(onPressed: (){
                                    print("Track Order");
                                },
                                child:Text("Account")
                                )
                            ),
                            SizedBox(height:30),
                            SizedBox(
                                width:200,
                                child:ElevatedButton(onPressed: (){
                                    print("Track Order");
                                },
                                child:Text("Logout")
                                )
                            ),



                        ],
                        )

                    ),
                    SizedBox(width:30),
                    SizedBox(
                        
                        height:300,
                        
                        child:ElevatedButton(onPressed: (){

                        }, child:Column(children: [
                            Text("Electronics"),
                            SizedBox(height:30)
                        ],)
                        ),
                    )

                    
                ]

                )
                ],)

                )

            );
       
    }

}