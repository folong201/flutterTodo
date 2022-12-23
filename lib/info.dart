import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("info Page"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text("Creation",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  decoration:TextDecoration.underline,
                ),),
                subtitle: Text(
                    "to create and element you should clik on the button with + icon at the rigth bottom ot the screem.\n then you will fill th both form for the title and the description of the task and click on save to submit you data",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w400),),
              ),
            ),
            Container(color: Color.fromARGB(132, 0, 0, 0),height: 5,),
            ListTile(
              title: Text("Updating",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  decoration:TextDecoration.underline,
                ),),
              subtitle: Text(
                  "to update and element you should swipe it to the rigth side.\n then you will make you changes and click on save Button to save you Updated   datas",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w400),),
            ),
            Container(color: Color.fromARGB(132, 0, 0, 0),height: 5,),

            ListTile(
              title: Text("Delete",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  decoration:TextDecoration.underline,
                ),),
              subtitle: Text(
                  "to Delete and element you just have to swipe it to the left side and confirm the dialog that will apeart",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w400),),
            ),
            SizedBox(height: 100,),
            Center(
              child: Text("bY: Folong201."),
            )
          ],
        ));
  }
}
