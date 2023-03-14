import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NavJobDetailsExpandedPage extends StatefulWidget {
  @override
  _NavJobDetailsExpandedPageState createState() =>
      _NavJobDetailsExpandedPageState();
}

class _NavJobDetailsExpandedPageState extends State<NavJobDetailsExpandedPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Jobs',
            // style: TextStyle(
            //   color: AppColors.backgroundColor,
            // ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Job Title",
                                    style: TextStyle(
                                      fontSize: Dimension.text_size_medium,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Job Category Name",
                                    style: TextStyle(
                                      fontSize: Dimension.text_size_semi_medium,
                                      color: AppColors.textColorGrey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.dollarSign,
                                        color: Colors.green,
                                        size: Dimension.icon_size_small,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        "7850",
                                        style: TextStyle(
                                          fontSize: Dimension.text_size_small,
                                          color: AppColors.textColorGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.flag,
                                        size: Dimension.icon_size_small,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        "United States",
                                        style: TextStyle(
                                          fontSize: Dimension.text_size_small,
                                          color: AppColors.textColorGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.copy,
                                        color: Colors.blue,
                                        size: Dimension.icon_size_small,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        "fixed",
                                        style: TextStyle(
                                          fontSize: Dimension.text_size_small,
                                          color: AppColors.textColorGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_outlined,
                                        color: Colors.red,
                                        size: Dimension.icon_size_small,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        "Less than a week",
                                        style: TextStyle(
                                          fontSize: Dimension.text_size_small,
                                          color: AppColors.textColorGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Row(
                                children: [
                                  // SizedBox(
                                  //   width: 20.0,
                                  // ),
                                  Container(
                                    color: Colors.black,
                                    height: 90,
                                    width: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "5",
                                          style: TextStyle(
                                              color: Color(0xffE17C21),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("Proposals")
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Project Detail",
                              style: TextStyle(
                                fontSize: Dimension.text_size_medium,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. \n\nIt was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                              style: TextStyle(
                                fontSize: Dimension.text_size_small,
                                color: AppColors.textColorGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Attachments",
                      style: TextStyle(
                        fontSize: Dimension.text_size_medium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black54,
                            ),
                            // color: AppColors.textColorGrey,
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(10),
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "FileName.zip",
                                  style: TextStyle(
                                    fontSize: Dimension.text_size_small,
                                    color: AppColors.textColorGrey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "file size ",
                                      style: TextStyle(
                                        fontSize: Dimension.text_size_small,
                                        color: AppColors.textColorGrey,
                                      ),
                                    ),
                                    Text(
                                      "800 KB",
                                      style: TextStyle(
                                        fontSize: Dimension.text_size_small,
                                        color: AppColors.textColorGrey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.download_sharp,
                                      size: Dimension.icon_size_medium,
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black54,
                            ),
                            // color: AppColors.textColorGrey,
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(10),
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "FileName.zip",
                                  style: TextStyle(
                                    fontSize: Dimension.text_size_small,
                                    color: AppColors.textColorGrey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "file size ",
                                      style: TextStyle(
                                        fontSize: Dimension.text_size_small,
                                        color: AppColors.textColorGrey,
                                      ),
                                    ),
                                    Text(
                                      "800 KB",
                                      style: TextStyle(
                                        fontSize: Dimension.text_size_small,
                                        color: AppColors.textColorGrey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.download_sharp,
                                      size: Dimension.icon_size_medium,
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black54,
                            ),
                            // color: AppColors.textColorGrey,
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(10),
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "FileName.zip",
                                  style: TextStyle(
                                    fontSize: Dimension.text_size_small,
                                    color: AppColors.textColorGrey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "file size ",
                                      style: TextStyle(
                                        fontSize: Dimension.text_size_small,
                                        color: AppColors.textColorGrey,
                                      ),
                                    ),
                                    Text(
                                      "800 KB",
                                      style: TextStyle(
                                        fontSize: Dimension.text_size_small,
                                        color: AppColors.textColorGrey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.download_sharp,
                                      size: Dimension.icon_size_medium,
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                // Container(
                //   height: Get.height / 3,
                //   width: Get.width,
                //   child: GetX<HomeController>(initState: (state) {
                //     Get.find<HomeController>().getJobByCategoryContro();
                //   }, builder: (_) {
                //     return _.jobByCategoris.length > 0
                //         ? ListView.builder(
                //             scrollDirection: Axis.vertical,
                //             itemCount: _.jobByCategoris.length,
                //             itemBuilder: (context, index) {
                //               return Stack(
                //                 overflow: Overflow.visible,
                //                 children: [
                //                   Positioned(
                //                     child: Card(
                //                       color: Color(0xFFFFFCF3),
                //                       child: Column(
                //                         children: [
                //                           SizedBox(
                //                             height: 80,
                //                             child: ListTile(
                //                               title: Row(
                //                                 crossAxisAlignment:
                //                                     CrossAxisAlignment.baseline,
                //                                 children: [
                //                                   CircleAvatar(
                //                                     radius: 6,
                //                                     backgroundColor:
                //                                         Colors.green[600],
                //                                     child: Icon(
                //                                       Icons.check,
                //                                       size: 12,
                //                                     ),
                //                                   ),
                //                                   SizedBox(
                //                                     width: 10,
                //                                   ),
                //                                   Text(
                //                                     '${_.jobByCategoris[index].name}',
                //                                     style:
                //                                         TextStyle(fontSize: 16),
                //                                   ),
                //                                 ],
                //                               ),
                //                               subtitle: Column(
                //                                 crossAxisAlignment:
                //                                     CrossAxisAlignment.start,
                //                                 children: [
                //                                   Text(
                //                                     'Sub-Contractor',
                //                                     style: TextStyle(
                //                                         fontSize: 16,
                //                                         color: Colors.black),
                //                                   ),
                //                                   Row(
                //                                     children: [
                //                                       Text(
                //                                         '\$ 12/hr |',
                //                                         style: TextStyle(
                //                                           fontSize: 14,
                //                                         ),
                //                                       ),
                //                                       SizedBox(
                //                                         width: 10.0,
                //                                       ),
                //                                       Icon(
                //                                         FontAwesomeIcons.flag,
                //                                         size: Dimension
                //                                             .icon_size_small,
                //                                       ),
                //                                       SizedBox(
                //                                         width: 10.0,
                //                                       ),
                //                                       Text(
                //                                         'Uganda',
                //                                         style: TextStyle(
                //                                           fontSize: 14,
                //                                         ),
                //                                       ),
                //                                     ],
                //                                   ),
                //                                 ],
                //                               ),
                //                               leading: Container(
                //                                 height: 90,
                //                                 width: 60,
                //                                 color: Colors.grey,
                //                                 child: Align(
                //                                   alignment: Alignment.center,
                //                                   child: Text(
                //                                     '255x255',
                //                                     style:
                //                                         TextStyle(fontSize: 10),
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                           Padding(
                //                             padding: const EdgeInsets.all(15.0),
                //                             child: Text(
                //                               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.",
                //                               style: TextStyle(
                //                                 fontSize:
                //                                     Dimension.text_size_small,
                //                                 color: AppColors.textColorGrey,
                //                               ),
                //                             ),
                //                           ),
                //                           Padding(
                //                             padding: const EdgeInsets.all(15.0),
                //                             child: Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment
                //                                       .spaceBetween,
                //                               children: [
                //                                 Column(
                //                                   children: [
                //                                     Row(
                //                                       children: [
                //                                         Icon(
                //                                           Icons.star,
                //                                           size: 12,
                //                                           color: AppColors
                //                                               .textColorGrey,
                //                                         ),
                //                                         Icon(
                //                                           Icons.star,
                //                                           size: 12,
                //                                           color: AppColors
                //                                               .textColorGrey,
                //                                         ),
                //                                         Icon(
                //                                           Icons.star,
                //                                           size: 12,
                //                                           color: AppColors
                //                                               .textColorGrey,
                //                                         ),
                //                                         Icon(
                //                                           Icons.star,
                //                                           size: 12,
                //                                           color: AppColors
                //                                               .textColorGrey,
                //                                         ),
                //                                         Icon(
                //                                           Icons.star,
                //                                           size: 12,
                //                                           color: AppColors
                //                                               .textColorGrey,
                //                                         ),
                //                                       ],
                //                                     ),
                //                                     Text(
                //                                       "0/5",
                //                                       style: TextStyle(
                //                                         fontSize: 12,
                //                                         color: AppColors
                //                                             .textColorGrey,
                //                                       ),
                //                                     ),
                //                                     Text(
                //                                       "(0 feedback)",
                //                                       style: TextStyle(
                //                                         fontSize: 12,
                //                                         color: Colors.orange,
                //                                       ),
                //                                     ),
                //                                   ],
                //                                 ),
                //                                 GestureDetector(
                //                                   onPressed: () {},
                //                                   color: Colors.blue,
                //                                   child: Text(
                //                                     'View Estimation',
                //                                     style: TextStyle(
                //                                       color: Colors.white,
                //                                       fontSize: Dimension
                //                                           .text_size_small,
                //                                     ),
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ),
                //                   Positioned(
                //                       child: Image.asset(
                //                     'images/premium.jpg',
                //                     height: 22,
                //                     width: 22,
                //                   )),
                //                   Positioned(
                //                     top: Get.height / 30,
                //                     left: Get.width / 1.1 - 18,
                //                     child: IconButton(
                //                       onPressed: () {},
                //                       icon: CircleAvatar(
                //                         backgroundColor: Colors.red,
                //                         radius: 10,
                //                         child: Icon(
                //                           Icons.favorite,
                //                           size: 12,
                //                           color: AppColors.backgroundColor,
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               );
                //             })
                //         : Center(child: CircularProgressIndicator());
                //   }),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
