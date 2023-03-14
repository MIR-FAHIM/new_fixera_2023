import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:get/get.dart';
import 'package:new_fixera/Controller/SendProposalController.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:http/http.dart' as http;
import 'package:new_fixera/Views/Screens/JobScreen/JobDetailsScreen/dynamicRow.dart';

class SendProposalPage extends StatefulWidget {
  @override
  _SendProposalPageState createState() => _SendProposalPageState();
}

class _SendProposalPageState extends State<SendProposalPage> {
  final SendProposalController _sendProposalController = Get.put(
      SendProposalController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Send Proposal"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.done), onPressed: _sendProposalController.onDone),
        body: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: Get.height,
              width: Get.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Test Project from Lead",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "\$\$\$",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text("10000"),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.flag,
                          size: Dimension.icon_size_medium,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text("United Kingdom"),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.folder,
                          size: Dimension.icon_size_medium,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text("Type Fixed"),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.hourglass,
                          size: Dimension.icon_size_medium,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text("Duration"),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Proposal Amount",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      maxLines: 1,
                      //controller: _sendProposalController.pAmountController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: new InputDecoration(
                        labelText: 'Enter your Proposal Amount (\$)',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value) {
                        _sendProposalController.pAmount.value = value;
                        _sendProposalController.caluculation();
                      },
                      validator: (value) {
                        if (value!.trim().isEmpty)
                          return "Enter your proposal Amount";
                        else
                          return null;
                      },
                    ),
                    Text(
                      "(Total Amount the client will see on your Proposal)",
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Obx(() {
                      return Text(
                        "FixEra Service Fee (\$)            :  ${_sendProposalController.serv.value == null ? 0.0 : _sendProposalController.serv.value}",
                        style: TextStyle(fontSize: 12),
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(),
                    Obx(() {
                      return Text(
                        "You'll Receive Amount After\nService Fee Duduction (\$)   :  ${_sendProposalController.recev.value}",
                        style: TextStyle(fontSize: 12),
                      );
                    }),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: 24),
                    //   child: Container(
                    //     padding: EdgeInsets.all(6),
                    //     decoration: BoxDecoration(
                    //         border: Border.all(
                    //             color: Colors.grey, width: 1)),
                    //     child: DropdownButton(
                    //       isExpanded: true,
                    //       hint: Text(
                    //         "SELECT PROJECT DURATION",
                    //         style: TextStyle(fontSize: 14),
                    //       ),
                    //       items: postAJobController.postAjobList.value
                    //           .results.projectDuration.keys
                    //           .map((values) {
                    //         return DropdownMenuItem(
                    //           value: values,
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(
                    //                 left: 8.0, right: 8.0),
                    //             child: Text(
                    //               postAJobController.postAjobList.value
                    //                   .results.projectDuration[values],
                    //               style: TextStyle(),
                    //             ),
                    //           ),
                    //         );
                    //       }).toList(),
                    //       value: projectDuration,
                    //       underline: SizedBox(),
                    //       onChanged: (valueSelectedByUser) {
                    //         setState(() {
                    //           projectDuration = valueSelectedByUser;
                    //           print(projectDuration);
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 8),
                    TextField(
                      autofocus: false,
                      focusNode: FocusNode(),
                      controller: _sendProposalController.coverletterController,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: 'Cover Letter',
                          border: OutlineInputBorder(gapPadding: 16)),
                    ),
                    GestureDetector(
                      onTap: () {},

                      child: Text(
                        "Upload File",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Text("(Optional)",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.grey)),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Product Description",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: Get.height/1.2,
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DymanicCard(),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 500,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
