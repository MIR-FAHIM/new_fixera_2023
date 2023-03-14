import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/AppDimension.dart';
import 'package:new_fixera/Views/Widget/NormalAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class WorkOrderVendorPage extends StatefulWidget {
  WorkOrderVendorPage({Key? key}) : super(key: key);

  @override
  _WorkOrderVendorPageState createState() => _WorkOrderVendorPageState();
}

class _WorkOrderVendorPageState extends State<WorkOrderVendorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Workorder"),),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                ),
                Container(
                  height: Get.height / 3,
                  width: Get.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 8),
                      Container(
                        color: Colors.black,
                        height: 160,
                        width: 0.8,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Vendor",
                            style: TextStyle(
                                color: AppColors.textColorGreen,
                                fontSize: Dimension.text_size_medium,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Sample Client Limited",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Sample Person",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            "100 Sample Street",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            "London",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            "W1 1AB",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            "United Kingdom",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(width: 2),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Card(
                          elevation: 0,
                          color: AppColors.textColorBlack,
                          child: Padding(
                            padding: const EdgeInsets.all(1.2),
                            child: Container(
                              height: 120,
                              width: 180,
                              color: AppColors.containerColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Job Number",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Text(
                                          "#1108",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Order Number",
                                          style: TextStyle(
                                              color: AppColors.textColorGrey,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "#1108-6",
                                          style: TextStyle(
                                              color: AppColors.textColorGrey,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Assigned",
                                          style: TextStyle(
                                              color: AppColors.textColorGrey,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "29/09/2020",
                                          style: TextStyle(
                                              color: AppColors.textColorGrey,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Order Total ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.textColorRed,
                                          ),
                                        ),
                                        Text(
                                          "\$5000",
                                          style: TextStyle(
                                              color: AppColors.textColorRed,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: DataTable(
                        columnSpacing: 25,
                        horizontalMargin: 8,
                        dividerThickness: 0,
                        dataTextStyle: TextStyle(
                          fontSize: 12,
                          color: AppColors.textColorBlack,
                        ),
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) => AppColors.primaryColor,
                        ),
                        columns: <DataColumn>[
                          DataColumn(
                              label: Text(
                            'Item',
                          )),
                          DataColumn(
                            label: Text('Description'),
                          ),
                          DataColumn(label: Text('Ut')),
                          DataColumn(label: Text('Qty')),
                          DataColumn(label: Text('Total'))
                        ],
                        rows: <DataRow>[
                          DataRow(
                            color: MaterialStateColor.resolveWith(
                              (states) => AppColors.containerColor,
                            ),
                            cells: <DataCell>[
                              DataCell(
                                Container(
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Item 01'),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(child: Text('Description')),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('0')),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('0')),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('0.0')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            color: MaterialStateColor.resolveWith(
                              (states) => AppColors.containerColor,
                            ),
                            cells: <DataCell>[
                              DataCell(
                                Container(
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Item 01'),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(child: Text('Description')),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('0')),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('0')),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('0.0')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Get.width,
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "+ Add New Item",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  indent: 8,
                  endIndent: 8,
                  height: 1,
                  thickness: 2,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Sub-Total",
                                style: TextStyle(
                                    color: AppColors.textColorBlack,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 42,
                              ),
                              Text(
                                "0.00",
                                style: TextStyle(
                                    color: AppColors.textColorBlack,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Discount",
                                style: TextStyle(
                                    color: AppColors.textColorBlack,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                "0.00",
                                style: TextStyle(
                                    color: AppColors.textColorBlack,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                    indent: 150,
                    endIndent: 8,
                    height: 2,
                    thickness: 2,
                    color: AppColors.textColorBlack),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Grand Total",
                            style: TextStyle(
                              color: AppColors.textColorBlack,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "0.00",
                            style: TextStyle(
                              color: AppColors.textColorBlack,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Site Information",
                        style: TextStyle(
                          color: AppColors.textColorGreen,
                          fontSize: Dimension.text_size_medium,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        color: AppColors.textColorBlack,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            height: 40,
                            width: 200,
                            color: AppColors.containerColor,
                            child: Center(
                              child: Text(
                                "Customer Contact",
                                style: TextStyle(
                                  color: AppColors.textColorBlack,
                                  fontSize: Dimension.text_size_medium,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        color: AppColors.textColorBlack,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            height: 140,
                            width: 200,
                            color: AppColors.containerColor,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Silver City Apts Fire B 2228 Birch DriveKansas City KS 2656",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppColors.textColorGrey,
                                    fontSize: Dimension.text_size_medium,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Text(
                        "Terms",
                        style: TextStyle(
                          fontSize: Dimension.text_size_medium,
                          color: AppColors.textColorBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        color: AppColors.textColorBlack,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            height: Get.height / 2.5,
                            width: Get.width / 1.1,
                            color: AppColors.containerColor,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                          "All Invoices must be turned in by Tuesday by Midnight and work completed for payroll on Fridays. Al checks will be released once certification completion is signed off on jobs over 1,000.00. After certification is completed then that 20% held will be released to the contractor. Job site must be cleaned up daily after all work is finished. Afterwork order is signed, Contractor must show up on site or notifyVendor manager with any problems. Penalty for not following these steps will cause a deduction of 250 towards final payment.",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: AppColors.textColorGrey,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {},

                  child: Text(
                    'ACCEPT & START',
                    style: TextStyle(
                      color: AppColors.textColorWhite,
                      fontSize: Dimension.text_size_medium_large,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
