import 'package:flutter/material.dart';

class ProjectAddItems extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextField(
            // controller: _jobTitle,
            autofocus: false,
            focusNode: FocusNode(),
            decoration: InputDecoration(
                hintText: 'Type of Project',
                border: OutlineInputBorder()),
          ),
        ),

        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextField(
            // controller: _jobTitle,
            autofocus: false,
            focusNode: FocusNode(),
            decoration: InputDecoration(
                hintText: 'Select Measurement',
                border: OutlineInputBorder()),
          ),
        ),

        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextField(
            // controller: _jobTitle,
            autofocus: false,
            focusNode: FocusNode(),
            decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder()),
          ),
        ),

        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextField(
            // controller: _jobTitle,
            autofocus: false,
            focusNode: FocusNode(),
            decoration: InputDecoration(
                hintText: 'Quantity',
                border: OutlineInputBorder()),
          ),
        ),

        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextField(
            // controller: _jobTitle,
            autofocus: false,
            focusNode: FocusNode(),
            decoration: InputDecoration(
                hintText: 'Per Unit Charge',
                border: OutlineInputBorder()),
          ),
        ),

        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextField(
            // controller: _jobTitle,
            autofocus: false,
            focusNode: FocusNode(),
            decoration: InputDecoration(
                hintText: 'Price',
                border: OutlineInputBorder()),
          ),
        ),
        SizedBox(height: 16,),
        Row(
          children: [
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 40,width: 50,
                  child: Icon(Icons.delete, color: Colors.white,size: 30,),
                ),
              ),
            ),
            // SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffA0C828),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 40,width: 50,
                  child: Icon(Icons.add, color: Colors.white,size: 30,),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16,),
      ],
    );
  }
}
