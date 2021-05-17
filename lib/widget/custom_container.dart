import 'package:flutter/material.dart';
class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key key,
    @required this.name,
    @required this.description,
    @required this.imagePath,
  }) : super(key: key);


  final String name;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            margin: EdgeInsets.only(top: 40),
            height: size.height * .25,
            width: size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff193B68).withOpacity(0.05),
                  offset: Offset(0, 0), //(x,y)
                  blurRadius: 10.0,
                ),
              ],
              color: Colors.white70,
              borderRadius: BorderRadius.circular(8.0),
              //border: Border.all(color: Color(0xff4b6584)),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text( description, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.blue),),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            child: Container(
              height: size.height * .15,
              width: size.width,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff193B68).withOpacity(0.05),
                      offset: Offset(0, 0), //(x,y)
                      blurRadius: 10.0,
                    ),
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('$imagePath')
                  )
              ),

            )
        ),
      ],
    );
  }
}