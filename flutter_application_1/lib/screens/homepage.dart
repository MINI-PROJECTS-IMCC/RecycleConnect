import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:http/http.dart";
import "package:flutter_svg/svg.dart";
class HomePage extends StatefulWidget{

    const HomePage({super.key});

    @override
    State<HomePage> createState()=>_Home();

}
class _Home extends State<HomePage>{
    Widget _buildCategoryCard(String icon,String title,String description){
        return Card(
            elevation:3,
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child:InkWell(
            onTap: (){

            },
            borderRadius: BorderRadius.circular(20),
            child:Padding(padding: EdgeInsets.all(50),child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:[
                        
                Text("$icon $title",style:TextStyle(fontSize:35)),
                Divider(),
                SizedBox(height:30),
                Text("This includes:-$description",style:TextStyle(fontSize:20))
            ]
            )),
            )

        );
    }
   

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
            body:
            SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child:LayoutBuilder(builder: (context,constraints)
                {
                    int crossAxisCount=1;
                    if(constraints.maxWidth>=900){
                        crossAxisCount=3;//for laptop
                    }
                    else if(constraints.maxWidth>=600){
                        crossAxisCount=2;//tablet
                    }
                    else {
                        crossAxisCount=1;//mobile
                    }
                    return GridView.count( 
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 2,
                        children: [
                            _buildCategoryCard("📃","Paper","newspaper,books")
                        ],

                    );
                })
            )
            /*Column(
              
                children: [
                Wrap(
                    spacing: 16,
                    runSpacing: 20,
                
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
                        
                            Text("🧴 Plastic",style:TextStyle(fontSize:35)),
                            SizedBox(height:30),
                            Text("This includes:-Plastic bags,Water Bottles,Soda Bottles,Milk jugs & shampoo bottles",style:TextStyle(fontSize:20))
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
                        
                            Text("📃 Papers",style:TextStyle(fontSize:35)),
                            SizedBox(height:30),
                            Text("This includes:-NewsPaper,Books,Sheets",style:TextStyle(fontSize:20))
                        ]
                    )),
                    )

                ),
                Card(
                    elevation:3,
                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                    child:InkWell(
                        onTap:(){

                        },
                        borderRadius: BorderRadius.circular(20),
                        child:Padding(padding:EdgeInsets.all(50),child:Column(
                            mainAxisSize:MainAxisSize.min,children: [
                                Text("🔌 E-Waste",style:TextStyle(fontSize:35)),
                                SizedBox(height:30),
                                Text("This includes:-phones,laptop,wires,leds,bulbs",style:TextStyle(fontSize:20))
                            ],))
                    )
                )
            ],)

            ],)*/
            
            

            );
       
    }

}