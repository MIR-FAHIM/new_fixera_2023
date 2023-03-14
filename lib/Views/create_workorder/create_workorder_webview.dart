import 'package:new_fixera/Model/Create%20Work%20Order/create_work_order.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Widgets/text_field_title.dart';
import 'package:new_fixera/Widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_fixera/Controller/ContractorController.dart';
import 'package:new_fixera/Views/Screens/BottomNavigationScreen/BottomNavigationPage.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import "package:get/get.dart" hide MultipartFile, Response, FormData;

class CreateWorkOrderWebview extends StatefulWidget {
  CreateWorkOrderWebview({Key? key}) : super(key: key);

  @override
  _PostAJobAndLeadState createState() => _PostAJobAndLeadState();
}

class _PostAJobAndLeadState extends State<CreateWorkOrderWebview> {
  List imageFiles = [];
  List<Widget> list = [];
  var _currencies = [
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
  var loaderStatus = false;
  TextEditingController ReceivableEmailController = TextEditingController();
  TextEditingController CompanyNameController = TextEditingController();
  TextEditingController CompanyAddressController = TextEditingController();
  TextEditingController JobNameController = TextEditingController();
  TextEditingController CrewController = TextEditingController();
  TextEditingController CustomerNameController = TextEditingController();
  TextEditingController CustomerAddressController = TextEditingController();
  TextEditingController CompanyRepresentativeNameController =
      TextEditingController();
  TextEditingController CompanyRepresentativeEmailController =
      TextEditingController();
  TextEditingController CompanyRepresentativePhoneController =
      TextEditingController();
  TextEditingController ProposalAmountController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  TextEditingController DisclimerController = TextEditingController();
  String? StartDate;
  String? EndDate;

  List<WorkOrderAddModelUI> AddWorkOrderList = [
    WorkOrderAddModelUI(),
  ];
  DateTime? _selectedDate;

  var _formKey = GlobalKey<FormState>();
  Future<String> selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light(),
            child: child!,
          );
        });
    if (newSelectedDate != null) {
      //2022-12-26
      return "${newSelectedDate.year}-${newSelectedDate.month}-${newSelectedDate.day}";
    }
    return '';
  }

  String _currentSelectedValue = 'DA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Create WorkOrder"),
        leading: GestureDetector(
          onTap: () {
           Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //*****

                      //*****

                      SizedBox(height: 16),
                      TextFieldTitle("Receivable Email"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Receivable Email",
                        controller: ReceivableEmailController,
                        onChanged: (v) {},
                        validator: (value) =>
                            value == null ? 'Email cannot be blank' : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Company Name"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Company Name",
                        controller: CompanyNameController,
                        onChanged: (v) {},
                        validator: (value) => value == null
                            ? 'Company Name cannot be blank'
                            : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),

                      SizedBox(height: 16),
                      TextFieldTitle("Company Address"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Company Address",
                        controller: CompanyAddressController,
                        onChanged: (v) {},
                        validator: (value) => value == null
                            ? 'Company Address cannot be blank'
                            : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Job Name"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Job Name",
                        controller: JobNameController,
                        onChanged: (v) {},
                        validator: (value) =>
                            value == null ? 'Job Name cannot be blank' : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Crew"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Crew",
                        controller: CrewController,
                        onChanged: (v) {},
                        validator: (value) =>
                            value == null ? 'Crew cannot be blank' : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Start Date"),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          StartDate = await selectDate(context);
                          setState(() {
                            StartDate;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Container(
                              height: 65,
                              width: Get.width,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(StartDate ?? '')),
                              )),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("End Date"),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          EndDate = await selectDate(context);
                          setState(() {
                            EndDate;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Container(
                              height: 65,
                              width: Get.width,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                // color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(EndDate ?? '')),
                              )),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Customer Name"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Customer Name",
                        controller: CustomerNameController,
                        onChanged: (v) {},
                        validator: (value) => value == null
                            ? 'Customer Name cannot be blank'
                            : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Customer Address"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Customer Address",
                        controller: CustomerAddressController,
                        onChanged: (v) {},
                        validator: (value) => value == null
                            ? 'Customer Address cannot be blank'
                            : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Company Representative Name"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Company Representative Name",
                        controller: CompanyRepresentativeNameController,
                        onChanged: (v) {},
                        validator: (value) =>
                            value == null ? 'Name cannot be blank' : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Company Representative Email"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Company Representative Email",
                        controller: CompanyRepresentativeEmailController,
                        onChanged: (v) {},
                        validator: (value) =>
                            value == null ? 'Email cannot be blank' : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Company Representative Phone"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Company Representative Phone",
                        controller: CompanyRepresentativePhoneController,
                        onChanged: (v) {},
                        validator: (value) =>
                            value == null ? 'Phone cannot be blank' : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Proposal Amount"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Proposal Amount",
                        controller: ProposalAmountController,
                        onChanged: (v) {},
                        validator: (value) => value == null
                            ? 'Proposal Amount cannot be blank'
                            : "",
                        keyboardType: TextInputType.number,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      TextFieldTitle("Description"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Description",
                        controller: DescriptionController,
                        onChanged: (v) {},
                        validator: (value) => value == null
                            ? 'Description cannot be blank'
                            : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(height: 16),
                      ...AddWorkOrderList.map(
                        (e) => Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: TextFormField(
                                controller: e.MaterialQtyController,
                                autofocus: false,
                                focusNode: FocusNode(),
                                decoration: InputDecoration(
                                    hintText: 'Material Qty',
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: FormField(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16.0),
                                        hintText: 'DA',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    // isEmpty: currentSelectedValue == '',
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _currentSelectedValue,
                                        isDense: true,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _currentSelectedValue = newValue!;
                                            e.MaterialUnitController = newValue;
                                          });
                                        },
                                        items: _currencies.map((String value) {
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: TextFormField(
                                controller: e.MaterialDescriptionController,
                                autofocus: false,
                                focusNode: FocusNode(),
                                decoration: InputDecoration(
                                    hintText: 'Material Description',
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Divider(
                              color: Colors.black54,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                AddWorkOrderList.add(WorkOrderAddModelUI());
                              });
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
                                  height: 40,
                                  width: 50,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (AddWorkOrderList.length > 1) {
                                  AddWorkOrderList.removeLast();
                                }
                              });
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
                                  height: 40,
                                  width: 50,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return list[index];
                          }),
                      SizedBox(height: 16),
                      TextFieldTitle("Disclaimer"),
                      SizedBox(height: 16),
                      TextFieldWidget(
                        title: "Disclaimer",
                        controller: DisclimerController,
                        onChanged: (v) {},
                        validator: (value) =>
                            value == null ? 'Disclaimer cannot be blank' : "",
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      loaderStatus
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : InkWell(
                              onTap: () async {
                                setState(() {
                                  loaderStatus = true;
                                });
                                var result = await create_work_order_model(
                                  receivable_email:
                                      ReceivableEmailController.text,
                                  comapny_name: CompanyNameController.text,
                                  comapny_address:
                                      CompanyAddressController.text,
                                  job_name: JobNameController.text,
                                  work_order_crew: CrewController.text,
                                  work_order_start: StartDate,
                                  work_order_end: EndDate,
                                  customer_name: CustomerNameController.text,
                                  customer_address:
                                      CustomerAddressController.text,
                                  com_rep_name:
                                      CompanyRepresentativeNameController.text,
                                  com_rep_email:
                                      CompanyRepresentativeEmailController.text,
                                  com_rep_phone:
                                      CompanyRepresentativePhoneController.text,
                                  work_order_total_amount:
                                      ProposalAmountController.text,
                                  work_order_decs: DescriptionController.text,
                                  work_order_disclaimer:
                                      DisclimerController.text,
                                ).save(AddWorkOrderList);
                                setState(() {
                                  loaderStatus = false;
                                });
                                if (result == true) {
                                  Get.back();
                                  Get.snackbar("Success", "Work Order Created");
                                } else {
                                  Get.snackbar(
                                      "Error", "Work Order Not Created");
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffA0C828),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 50,
                                width: 160,
                                child: Center(
                                    child: Text(
                                  "Send",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
