import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Controller/SendProposalController.dart';

class DymanicCard extends StatefulWidget {
  @override
  _DymanicCardState createState() => _DymanicCardState();
}

class _DymanicCardState extends State<DymanicCard> {
  final SendProposalController _sendProposalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 1.2,
      width: Get.width,
     
      child: Column(
        children: <Widget>[
          GetBuilder<SendProposalController>(
            builder: (_sendProposalController) {
              return Expanded(
                child: ListView.builder(
                  itemCount: _sendProposalController.cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        _sendProposalController.cards[index],
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: InkWell(
                                onTap: () {
                                  _sendProposalController.addProduct();
                                },
                                child: Card(
                                  elevation: 8,
                                  child: Container(
                                    height: 60,
                                    width: 30,
                                    color: AppColors.primaryColor,
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: _sendProposalController.cards.length == 1
                                  ? Text("")
                                  : InkWell(
                                      onTap: () {
                                        _sendProposalController
                                            .removeProduct();
                                      },
                                      child: Card(
                                        elevation: 8,
                                        child: Container(
                                          height: 60,
                                          width: 30,
                                          color: Colors.red,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
