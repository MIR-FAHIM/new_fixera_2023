import 'package:new_fixera/Widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class IncoicePageProductAdd extends StatefulWidget {
  const IncoicePageProductAdd({Key? key}) : super(key: key);

  @override
  _IncoicePageProductAddState createState() => _IncoicePageProductAddState();
}

class _IncoicePageProductAddState extends State<IncoicePageProductAdd> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(height: 16),
        // TextFieldWidget("Title"),
        // SizedBox(height: 16),
        // TextFieldWidget("Rate"),
        // SizedBox(height: 16),
        // TextFieldWidget("Quantity"),
        // SizedBox(height: 16),
        // TextFieldWidget("Amount"),
        // SizedBox(height: 16),

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
            InkWell(
              onTap: (){

              },
              child: Padding(
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
            ),
          ],
        ),
        SizedBox(height: 16,),
        Divider(color: Colors.black,),
        SizedBox(height: 16,),
      ],
    );
  }
}
