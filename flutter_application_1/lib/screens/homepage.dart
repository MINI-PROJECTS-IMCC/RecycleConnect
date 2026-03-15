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

     double screenHeight = MediaQuery.of(context).size.height;
     double screenWidth = MediaQuery.of(context).size.width;
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.green,
                title:Row(children: [
                    Text("♻️ Recycle Connect.in",style:TextStyle(color:Colors.white,fontSize:20)),
                    SizedBox(width:20),
                    Expanded(child: TextField(decoration: InputDecoration(hintText: "Search items or organizations",border:OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none),filled:true,fillColor: Colors.white,prefixIcon: Icon(Icons.search)),),
                    ),
                    SizedBox(width:20),
                    TextButton(onPressed: (){

                    },child:Text("About❔",style:TextStyle(color:Colors.white,fontSize: 20)))
                    
                ],)
                //all left widgets
            ),
            drawer:Drawer(
                child:Column(children: [
                    DrawerHeader(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            CircleAvatar(
                                radius:50,
                                backgroundColor: Colors.grey,
                                child: Text("V",style:TextStyle(fontSize: 40,color:Colors.white)),
                            ),
                            SizedBox(height:9),
                            Text("Welcome Vallabh Punekar 😊")

                            
                        ],
                    )),
                    ListTile(//to add items in drawer/sidebar
                    leading:Icon(Icons.home_outlined),
                    title: Text("Home"),
                    onTap: (){
                        Navigator.pop(context);
                    }
                    ,
                    ),
                    ListTile(
                        leading:Text("🗑️",style:TextStyle(fontSize:20)),
                        title:Text("Open Bin"),
                        onTap:(){
                            Navigator.pop(context);
                        }
                    ),
                    ListTile(
                        leading:Text("🏢",style:TextStyle(fontSize:20)),
                        title:Text("Browse Organizations"),
                        onTap:(){
                            Navigator.pop(context);
                        }
                    ),
                    ListTile(
                        leading:Icon(Icons.list_alt_outlined),
                        title:Text("Track my Requests"),
                        onTap:(){
                            Navigator.pop(context);//closes side bar after clicking
                        }
                    ),
                    Spacer(),//added space till bottom
                    Divider(),//adds line (Hr)
                    ListTile(
                        leading:Icon(Icons.logout_outlined),
                        title:Text("Logout"),
                        onTap:(){
                            Navigator.pop(context);
                        }
                    )

                    


                ],)
                
            ),
            body:Row(
                
                children: [


                Card(//display cards in web page
                    elevation:3,
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child:InkWell(
                        onTap: (){

                            },
                        borderRadius: BorderRadius.circular(20),
                        child:Padding(padding: EdgeInsets.all(50),child:Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                        
                            Text("🧴 Plastic"),
                            SizedBox(height:30),
                            Text("This includes:-Plastic bags,Plastic Bottles")
                        ]
                    )),
                    )

                ),
                Card(//display cards in web page
                    elevation:3,
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child:InkWell(
                        onTap: (){

                            },
                        borderRadius: BorderRadius.circular(20),
                        child:Padding(padding: EdgeInsets.all(50),child:Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                        
                            Text("📃 Papers"),
                            SizedBox(height:30),
                            Text("This includes:-NewsPaper,Books,Sheets")
                        ]
                    )),
                    )

                ),
            ],)
            

            );
       
    }

}