import 'package:flutter/material.dart';

class AddSlot extends StatelessWidget {
  const AddSlot({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff4e5ae8)
        ),
        
      ),
      
    );
  }
}