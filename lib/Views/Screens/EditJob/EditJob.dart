import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:flutter/material.dart';


class EditJobPage extends StatefulWidget {
  EditJobPage({Key? key}) : super(key: key);

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  TextEditingController _jobTitle = TextEditingController();
  bool status = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Edit Job"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      color: Color(0xffA0C828),
                      height: 60,
                      width: 3,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Job Description",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimension.text_size_medium),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _jobTitle,
                  decoration: InputDecoration(
                      hintText: 'Job Title', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: DropdownButton(
                    items: null,
                    onChanged: null,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    hint: Text('Select Project Level'),
                    underline: SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: DropdownButton(
                    items: null,
                    onChanged: null,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    hint: Text('Select Job Duration'),
                    underline: SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: DropdownButton(
                    items: null,
                    onChanged: null,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    hint: Text('Select Freelancer Level'),
                    underline: SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: DropdownButton(
                    items: null,
                    onChanged: null,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    hint: Text('Select English Level'),
                    underline: SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _jobTitle,
                  decoration: InputDecoration(
                      hintText: 'Project Cost', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      color: Color(0xffA0C828),
                      height: 60,
                      width: 3,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Job Categories",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimension.text_size_medium),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: DropdownButton(
                    items: null,
                    onChanged: null,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    hint: Text('Select Job Categories'),
                    underline: SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      color: Color(0xffA0C828),
                      height: 60,
                      width: 3,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Languages",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimension.text_size_medium),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: DropdownButton(
                    items: null,
                    onChanged: null,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    hint: Text('Select Languages'),
                    underline: SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      color: Color(0xffA0C828),
                      height: 60,
                      width: 3,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Job Details",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimension.text_size_medium),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _jobTitle,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: 'Job Details', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      color: Color(0xffA0C828),
                      height: 60,
                      width: 3,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Skills Required",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimension.text_size_medium),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: DropdownButton(
                    items: null,
                    onChanged: null,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    hint: Text('Skills'),
                    underline: SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      color: Color(0xffA0C828),
                      height: 60,
                      width: 3,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Your Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimension.text_size_medium),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: DropdownButton(
                    items: null,
                    onChanged: null,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    hint: Text('Select Location'),
                    underline: SizedBox(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _jobTitle,
                  decoration: InputDecoration(
                      hintText: 'Your Address', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                    "Latitudes and Longitudes are compulsory to show that user on map and also for search on the basis of location",
                    style: TextStyle(
                      fontSize: Dimension.text_size_semi_medium,
                    )),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _jobTitle,
                  decoration: InputDecoration(
                      hintText: 'Enter Latitude', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _jobTitle,
                  decoration: InputDecoration(
                      hintText: 'Enter Longitude',
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Text("Featured Job",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimension.text_size_medium))),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          child: Text("Swicth")
                          ),
                        ),
                      ),
                    
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      color: Color(0xffA0C828),
                      height: 60,
                      width: 3,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Your Attachments",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimension.text_size_medium),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},

                      child: Text(
                        '   Update   ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimension.text_size_medium_large,
                        ),
                      ),
                    ),
                    SizedBox(width: 32),
                    GestureDetector(
                      onTap: () {},

                      child: Text(
                        '  Select File  ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimension.text_size_medium_large,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ));
  }
}
