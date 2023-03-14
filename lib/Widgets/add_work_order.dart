import 'package:flutter/material.dart';

class AddWorkOrder extends StatefulWidget {

  @override
  _AddWorkOrderState createState() => _AddWorkOrderState();
}

class _AddWorkOrderState extends State<AddWorkOrder> {

  var currencieslist = [
    "DA",
    "BF",
    "BG",
    "BUNDLE",
    "BX",
    "CF",
    "CR",
    "CY",
    "EA",
    "FT",
    "HR",
    "LB",
    "LF",
    "LY",
    "MB",
    "ML",
    "MN",
    "MO",
    "PL",
    "PT",
    "QT",
    "RL",
    "RM",
    "SF",
    "SQ",
    "SY",
    "TB",
    "TN",
    "UN",
    "WK",
    "MTH",
    "YR",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextField(
            // controller: _jobTitle,
            autofocus: false,
            focusNode: FocusNode(),
            decoration: InputDecoration(
                hintText: 'Material Qty',
                border: OutlineInputBorder()),
          ),
        ),
        SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  // labelStyle: textStyle,
                    errorStyle: TextStyle(
                        color: Colors.redAccent, fontSize: 16.0),
                    hintText: 'DA',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                // isEmpty: _currentSelectedValue == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // value: _currentSelectedValue,
                    isDense: true,
                    onChanged: (String? newValue) {
                      setState(() {



                      });
                    },
                    items: currencieslist.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
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
                hintText: 'Material Description',
                border: OutlineInputBorder()),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: SizedBox()),
            InkWell(
              onTap: (){

              },
              child: Padding(
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
        Divider(color: Colors.black,)
      ],
    );
  }
}
