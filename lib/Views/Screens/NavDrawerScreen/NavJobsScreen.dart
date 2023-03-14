import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NavJobPage extends StatefulWidget {
  NavJobPage({Key? key}) : super(key: key);

  @override
  _NavJobPageState createState() => _NavJobPageState();
}

class _NavJobPageState extends State<NavJobPage> {
  int grpVal = 0;
  grpValFunc(value) {
    setState(() {
      grpVal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar:AppBar(
              title: Text("Job"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Radio(
                            value: 0,
                            groupValue: grpVal,
                            onChanged: grpValFunc),
                        Text(
                          "Manage",
                          style: TextStyle(
                            fontSize: Dimension.text_size_semi_medium,
                          ),
                        ),
                        Radio(
                          value: 1,
                          groupValue: grpVal,
                          onChanged: grpValFunc,
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: Dimension.text_size_semi_medium,
                          ),
                        ),
                        Radio(
                          value: 2,
                          groupValue: grpVal,
                          onChanged: grpValFunc,
                        ),
                        Text(
                          "Ongoing",
                          style: TextStyle(
                            fontSize: Dimension.text_size_semi_medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // grpVal == 0
                  //     ? Padding(
                  //         padding: const EdgeInsets.only(
                  //           top: 1.0,
                  //           left: 5.0,
                  //           right: 5.0,
                  //           bottom: 0.0,
                  //         ),
                  //         child: GestureDetector(
                  //           child: Stack(
                  //             clipBehavior: Clip.none,
                  //             children: [
                  //               Card(
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(6.0),
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.center,
                  //                     children: [
                  //                       Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceEvenly,
                  //                         children: [
                  //                           Container(
                  //                             child: Column(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               children: [
                  //                                 Text(
                  //                                   "Job Title",
                  //                                   style: TextStyle(
                  //                                       fontSize: Dimension
                  //                                           .text_size_medium_large),
                  //                                 ),
                  //                                 Text(
                  //                                   "Job Category Name",
                  //                                   style: TextStyle(
                  //                                       fontSize: Dimension
                  //                                           .text_size_semi_medium),
                  //                                 ),
                  //                                 SizedBox(
                  //                                   height: 10,
                  //                                 ),
                  //                                 Row(
                  //                                   children: [
                  //                                     Icon(
                  //                                       FontAwesomeIcons
                  //                                           .dollarSign,
                  //                                       color: Colors.green,
                  //                                       size: Dimension
                  //                                           .icon_size_medium,
                  //                                     ),
                  //                                     SizedBox(
                  //                                       width: 15.0,
                  //                                     ),
                  //                                     Text(
                  //                                       "7850",
                  //                                       style: TextStyle(
                  //                                           fontSize: Dimension
                  //                                               .text_size_semi_medium),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                                 SizedBox(
                  //                                   height: 10,
                  //                                 ),
                  //                                 Row(
                  //                                   children: [
                  //                                     Icon(
                  //                                       FontAwesomeIcons.flag,
                  //                                       size: Dimension
                  //                                           .icon_size_medium,
                  //                                     ),
                  //                                     SizedBox(
                  //                                       width: 15.0,
                  //                                     ),
                  //                                     Text(
                  //                                       "United States",
                  //                                       style: TextStyle(
                  //                                           fontSize: Dimension
                  //                                               .text_size_semi_medium),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                                 SizedBox(
                  //                                   height: 10,
                  //                                 ),
                  //                                 Row(
                  //                                   children: [
                  //                                     Icon(
                  //                                       Icons.copy,
                  //                                       color: Colors.blue,
                  //                                       size: Dimension
                  //                                           .icon_size_medium,
                  //                                     ),
                  //                                     SizedBox(
                  //                                       width: 15.0,
                  //                                     ),
                  //                                     Text(
                  //                                       "fixed",
                  //                                       style: TextStyle(
                  //                                           fontSize: Dimension
                  //                                               .text_size_semi_medium),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                                 SizedBox(
                  //                                   height: 10,
                  //                                 ),
                  //                                 Row(
                  //                                   children: [
                  //                                     Icon(
                  //                                       Icons
                  //                                           .access_time_outlined,
                  //                                       color: Colors.red,
                  //                                       size: Dimension
                  //                                           .icon_size_medium,
                  //                                     ),
                  //                                     SizedBox(
                  //                                       width: 15.0,
                  //                                     ),
                  //                                     Text(
                  //                                       "Less than a week",
                  //                                       style: TextStyle(
                  //                                           fontSize: Dimension
                  //                                               .text_size_semi_medium),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                           Padding(
                  //                             padding: const EdgeInsets.only(
                  //                                 top: 60),
                  //                             child: Row(
                  //                               children: [
                  //                                 Container(
                  //                                   color: Colors.black,
                  //                                   height: 120,
                  //                                   width: 2,
                  //                                 ),
                  //                                 Padding(
                  //                                   padding: const EdgeInsets
                  //                                           .symmetric(
                  //                                       horizontal: 40),
                  //                                   child: Column(
                  //                                     children: [
                  //                                       Text(
                  //                                         "5",
                  //                                         style: TextStyle(
                  //                                             color: Color(
                  //                                                 0xffE17C21),
                  //                                             fontSize: 20,
                  //                                             fontWeight:
                  //                                                 FontWeight
                  //                                                     .bold),
                  //                                       ),
                  //                                       Text("Proposals")
                  //                                     ],
                  //                                   ),
                  //                                 )
                  //                               ],
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                       SizedBox(
                  //                         height: 10,
                  //                       ),
                  //                       Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceEvenly,
                  //                         children: [
                  //                           GestureDetector(
                  //                             onTap: () {
                  //                               Get.toNamed(AppRoutes
                  //                                   .NAVJOBDETAILSPAGE);
                  //                             },
                  //
                  //                             child: Text(
                  //                               'View Details',
                  //                               style: TextStyle(
                  //                                 color: Colors.white,
                  //                                 fontSize: Dimension
                  //                                     .text_size_medium,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           GestureDetector(
                  //                             onTap: () {
                  //                               Get.toNamed(AppRoutes.EDITJOB);
                  //                             },
                  //
                  //                             child: Text(
                  //                               'Edit Job',
                  //                               style: TextStyle(
                  //                                 color:
                  //                                     AppColors.textColorWhite,
                  //                                 fontSize: Dimension
                  //                                     .text_size_medium,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           onTap: () {
                  //             // Get.toNamed(AppRoutes.JOBDETAILSPAGE);
                  //           },
                  //         ),
                  //       )
                  //     : grpVal == 1
                  //         ? Padding(
                  //             padding: const EdgeInsets.only(
                  //               top: 1.0,
                  //               left: 5.0,
                  //               right: 5.0,
                  //               bottom: 0.0,
                  //             ),
                  //             child: GestureDetector(
                  //               child: Stack(
                  //                 clipBehavior: Clip.none,
                  //                 children: [
                  //                   Card(
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.all(6.0),
                  //                       child: Column(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.center,
                  //                         children: [
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.spaceEvenly,
                  //                             children: [
                  //                               Container(
                  //                                 child: Column(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment
                  //                                           .start,
                  //                                   children: [
                  //                                     Text(
                  //                                       "Job Title",
                  //                                       style: TextStyle(
                  //                                           fontSize: Dimension
                  //                                               .text_size_medium_large),
                  //                                     ),
                  //                                     Text(
                  //                                       "Job Category Name",
                  //                                       style: TextStyle(
                  //                                           fontSize: Dimension
                  //                                               .text_size_semi_medium),
                  //                                     ),
                  //                                     SizedBox(
                  //                                       height: 10,
                  //                                     ),
                  //                                     Row(
                  //                                       children: [
                  //                                         Icon(
                  //                                           FontAwesomeIcons
                  //                                               .dollarSign,
                  //                                           color: Colors.green,
                  //                                           size: Dimension
                  //                                               .icon_size_medium,
                  //                                         ),
                  //                                         SizedBox(
                  //                                           width: 15.0,
                  //                                         ),
                  //                                         Text(
                  //                                           "7850",
                  //                                           style: TextStyle(
                  //                                               fontSize: Dimension
                  //                                                   .text_size_semi_medium),
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                     SizedBox(
                  //                                       height: 10,
                  //                                     ),
                  //                                     Row(
                  //                                       children: [
                  //                                         Icon(
                  //                                           FontAwesomeIcons
                  //                                               .flag,
                  //                                           size: Dimension
                  //                                               .icon_size_medium,
                  //                                         ),
                  //                                         SizedBox(
                  //                                           width: 15.0,
                  //                                         ),
                  //                                         Text(
                  //                                           "United States",
                  //                                           style: TextStyle(
                  //                                               fontSize: Dimension
                  //                                                   .text_size_semi_medium),
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                     SizedBox(
                  //                                       height: 10,
                  //                                     ),
                  //                                     Row(
                  //                                       children: [
                  //                                         Icon(
                  //                                           Icons.copy,
                  //                                           color: Colors.blue,
                  //                                           size: Dimension
                  //                                               .icon_size_medium,
                  //                                         ),
                  //                                         SizedBox(
                  //                                           width: 15.0,
                  //                                         ),
                  //                                         Text(
                  //                                           "fixed",
                  //                                           style: TextStyle(
                  //                                               fontSize: Dimension
                  //                                                   .text_size_semi_medium),
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                     SizedBox(
                  //                                       height: 10,
                  //                                     ),
                  //                                     Row(
                  //                                       children: [
                  //                                         Icon(
                  //                                           Icons
                  //                                               .access_time_outlined,
                  //                                           color: Colors.red,
                  //                                           size: Dimension
                  //                                               .icon_size_medium,
                  //                                         ),
                  //                                         SizedBox(
                  //                                           width: 15.0,
                  //                                         ),
                  //                                         Text(
                  //                                           "Less than a week",
                  //                                           style: TextStyle(
                  //                                               fontSize: Dimension
                  //                                                   .text_size_semi_medium),
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                               Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.only(
                  //                                         top: 60),
                  //                                 child: Row(
                  //                                   children: [
                  //                                     Container(
                  //                                       color: Colors.black,
                  //                                       height: 120,
                  //                                       width: 2,
                  //                                     ),
                  //                                     Padding(
                  //                                       padding:
                  //                                           const EdgeInsets
                  //                                                   .symmetric(
                  //                                               horizontal: 40),
                  //                                       child: Column(
                  //                                         children: [
                  //                                           Text(
                  //                                             "5",
                  //                                             style: TextStyle(
                  //                                                 color: Color(
                  //                                                     0xffE17C21),
                  //                                                 fontSize: 20,
                  //                                                 fontWeight:
                  //                                                     FontWeight
                  //                                                         .bold),
                  //                                           ),
                  //                                           Text("Proposals")
                  //                                         ],
                  //                                       ),
                  //                                     )
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                           SizedBox(
                  //                             height: 10,
                  //                           ),
                  //                           GestureDetector(
                  //                             onTap: () {},
                  //
                  //                             child: Text(
                  //                               'View Details',
                  //                               style: TextStyle(
                  //                                 color: Colors.white,
                  //                                 fontSize: Dimension
                  //                                     .text_size_medium,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               onTap: () {
                  //                 // Get.toNamed(AppRoutes.JOBDETAILSPAGE);
                  //               },
                  //             ),
                  //           )
                  //         : grpVal == 2
                  //             ? Padding(
                  //                 padding: const EdgeInsets.only(
                  //                   top: 1.0,
                  //                   left: 5.0,
                  //                   right: 5.0,
                  //                   bottom: 0.0,
                  //                 ),
                  //                 child: GestureDetector(
                  //                   child: Stack(
                  //                     clipBehavior: Clip.none,
                  //                     children: [
                  //                       Card(
                  //                         child: Padding(
                  //                           padding: const EdgeInsets.all(6.0),
                  //                           child: Column(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.center,
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.center,
                  //                             children: [
                  //                               Row(
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment
                  //                                         .spaceEvenly,
                  //                                 children: [
                  //                                   Container(
                  //                                     child: Column(
                  //                                       crossAxisAlignment:
                  //                                           CrossAxisAlignment
                  //                                               .start,
                  //                                       children: [
                  //                                         Text(
                  //                                           "Job Title",
                  //                                           style: TextStyle(
                  //                                               fontSize: Dimension
                  //                                                   .text_size_medium_large),
                  //                                         ),
                  //                                         Text(
                  //                                           "Job Category Name",
                  //                                           style: TextStyle(
                  //                                               fontSize: Dimension
                  //                                                   .text_size_semi_medium),
                  //                                         ),
                  //                                         SizedBox(
                  //                                           height: 10,
                  //                                         ),
                  //                                         Row(
                  //                                           children: [
                  //                                             Icon(
                  //                                               FontAwesomeIcons
                  //                                                   .dollarSign,
                  //                                               color: Colors
                  //                                                   .green,
                  //                                               size: Dimension
                  //                                                   .icon_size_medium,
                  //                                             ),
                  //                                             SizedBox(
                  //                                               width: 15.0,
                  //                                             ),
                  //                                             Text(
                  //                                               "7850",
                  //                                               style: TextStyle(
                  //                                                   fontSize:
                  //                                                       Dimension
                  //                                                           .text_size_semi_medium),
                  //                                             ),
                  //                                           ],
                  //                                         ),
                  //                                         SizedBox(
                  //                                           height: 10,
                  //                                         ),
                  //                                         Row(
                  //                                           children: [
                  //                                             Icon(
                  //                                               FontAwesomeIcons
                  //                                                   .flag,
                  //                                               size: Dimension
                  //                                                   .icon_size_medium,
                  //                                             ),
                  //                                             SizedBox(
                  //                                               width: 15.0,
                  //                                             ),
                  //                                             Text(
                  //                                               "United States",
                  //                                               style: TextStyle(
                  //                                                   fontSize:
                  //                                                       Dimension
                  //                                                           .text_size_semi_medium),
                  //                                             ),
                  //                                           ],
                  //                                         ),
                  //                                         SizedBox(
                  //                                           height: 10,
                  //                                         ),
                  //                                         Row(
                  //                                           children: [
                  //                                             Icon(
                  //                                               Icons.copy,
                  //                                               color:
                  //                                                   Colors.blue,
                  //                                               size: Dimension
                  //                                                   .icon_size_medium,
                  //                                             ),
                  //                                             SizedBox(
                  //                                               width: 15.0,
                  //                                             ),
                  //                                             Text(
                  //                                               "fixed",
                  //                                               style: TextStyle(
                  //                                                   fontSize:
                  //                                                       Dimension
                  //                                                           .text_size_semi_medium),
                  //                                             ),
                  //                                           ],
                  //                                         ),
                  //                                         SizedBox(
                  //                                           height: 10,
                  //                                         ),
                  //                                         Row(
                  //                                           children: [
                  //                                             Icon(
                  //                                               Icons
                  //                                                   .access_time_outlined,
                  //                                               color:
                  //                                                   Colors.red,
                  //                                               size: Dimension
                  //                                                   .icon_size_medium,
                  //                                             ),
                  //                                             SizedBox(
                  //                                               width: 15.0,
                  //                                             ),
                  //                                             Text(
                  //                                               "Less than a week",
                  //                                               style: TextStyle(
                  //                                                   fontSize:
                  //                                                       Dimension
                  //                                                           .text_size_semi_medium),
                  //                                             ),
                  //                                           ],
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                   ),
                  //                                   Padding(
                  //                                     padding:
                  //                                         const EdgeInsets.only(
                  //                                             top: 60),
                  //                                     child: Row(
                  //                                       children: [
                  //                                         Container(
                  //                                           color: Colors.black,
                  //                                           height: 120,
                  //                                           width: 2,
                  //                                         ),
                  //                                         Padding(
                  //                                           padding:
                  //                                               const EdgeInsets
                  //                                                       .symmetric(
                  //                                                   horizontal:
                  //                                                       40),
                  //                                           child: Column(
                  //                                             children: [
                  //                                               Text(
                  //                                                 "5",
                  //                                                 style: TextStyle(
                  //                                                     color: Color(
                  //                                                         0xffE17C21),
                  //                                                     fontSize:
                  //                                                         20,
                  //                                                     fontWeight:
                  //                                                         FontWeight
                  //                                                             .bold),
                  //                                               ),
                  //                                               Text(
                  //                                                   "Proposals")
                  //                                             ],
                  //                                           ),
                  //                                         )
                  //                                       ],
                  //                                     ),
                  //                                   )
                  //                                 ],
                  //                               ),
                  //                               SizedBox(
                  //                                 height: 10,
                  //                               ),
                  //                               Row(
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment
                  //                                         .spaceEvenly,
                  //                                 children: [
                  //                                   GestureDetector(
                  //                                     onTap: () {},
                  //
                  //                                     child: Text(
                  //                                       'View Details',
                  //                                       style: TextStyle(
                  //                                         color: Colors.white,
                  //                                         fontSize: Dimension
                  //                                             .text_size_medium,
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                   GestureDetector(
                  //                                     onTap: () {},
                  //
                  //                                     child: Text(
                  //                                       'Done',
                  //                                       style: TextStyle(
                  //                                         color: AppColors
                  //                                             .textColorWhite,
                  //                                         fontSize: Dimension
                  //                                             .text_size_medium,
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   onTap: () {
                  //                     // Get.toNamed(AppRoutes.JOBDETAILSPAGE);
                  //                   },
                  //                 ),
                  //               )
                  //             : null
                ],
              ),
            )));
  }
}
