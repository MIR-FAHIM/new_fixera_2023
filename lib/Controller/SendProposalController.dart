import 'package:get/get.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:new_fixera/Model/JobModel/ProductDescriptionModel.dart';

class SendProposalController extends GetxController {
  MyRepository? repository;
  SendProposalController({this.repository});
  final TextEditingController pAmountController = new TextEditingController();
  final TextEditingController coverletterController =
      new TextEditingController();

  var cardTECs = <TextEditingController>[];
  var productTECs = <TextEditingController>[];
  var desTECs = <TextEditingController>[];
  var quantityTECs = <TextEditingController>[];
  var unitTECs = <TextEditingController>[];
  var perUnitTECs = <TextEditingController>[];
  var priceTECs = <TextEditingController>[];
  var cards = <Card>[];
  List<ProductDescription> entries = [];

  final pAmount = "0".obs;
  var serv = "0".obs;
  var recev = "0".obs;
  double service = 0.0;
  double recceive = 0.0;
  var singleQuantity = "0".obs;
  var perUnit = "0".obs;
  List quantityCard = [].obs;
  List perUnitCard = [].obs;
  var price="0".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    cards.add(createCard());
  }

  caluculation() {
    if (pAmount.value != null) {
      service = (int.parse(pAmount.value) / 10);
      recceive = (int.parse(pAmount.value) - service);
      serv.value = service.toString();
      recev.value = recceive.toString();
      print(service.toDouble());
      print("check");
      print(recceive.toDouble());
    }
  }

  calculate() {
    quantityCard.add(singleQuantity.value);
    perUnitCard.add(perUnit.value);
    quantityCard.forEach((element) {
      print("quantity");
      print(element);
      print("success");
    });
    perUnitCard.forEach((element) {
      print("perUnit");
      print(element);
    });
  }

  Card createCard() {
    var cardController = TextEditingController();
    var productController = TextEditingController();
    var descriptionController = TextEditingController();
    var quantityController = TextEditingController();
    var unitController = TextEditingController();
    var perUnitController = TextEditingController();
    var priceController = TextEditingController();

    cardTECs.add(cardController);
    productTECs.add(productController);
    desTECs.add(descriptionController);
    quantityTECs.add(quantityController);
    unitTECs.add(unitController);
    perUnitTECs.add(perUnitController);
    priceTECs.add(priceController);

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
                controller: cardController,
                decoration: InputDecoration(labelText: 'Card Title')),
            TextField(
                controller: productController,
                decoration: InputDecoration(labelText: 'Product Title')),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description')),
            TextField(
                //controller: quantityController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  singleQuantity.value = value;
                  calculate();
                },
                decoration: InputDecoration(labelText: 'Quantity')),
            TextField(
                controller: unitController,
                decoration: InputDecoration(labelText: 'Unit')),
            TextField(
                // controller: perUnitController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  perUnit.value = value;
                  calculate();
                },
                decoration: InputDecoration(labelText: 'Per Unit Charge')),
            TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price')),
            // Obx(() {
            //   return Text("Price is  : ");
            // })
          ],
        ),
      ),
    );
  }

  onDone() {
    for (int i = 0; i < cards.length; i++) {
      var cardTile = cardTECs[i].text;
      var pTile = productTECs[i].text;
      var desTile = desTECs[i].text;
      var quanTile = quantityCard[i];
      //quantityTECs[i].text;
      var unitTile = unitTECs[i].text;
      var perUnitTile = perUnitTECs[i].text;
      var priceTile = priceTECs[i].text;
      entries.add(ProductDescription(cardTile, pTile, desTile, quanTile,
          unitTile, perUnitTile, priceTile));
    }
    entries.forEach((element) {
      print(element.cardTile);
      print(element.pTile);
      print(element.desTile);
      print(element.quantTile);
      print(element.unitTile);
      print(element.perUnitTile);
      print(element.priceTile);
    });

    update();
  }

  addProduct() {
    cards.add(createCard());
    update();
  }

  removeProduct() {
    if (cards.length == 1) {
      print("Not working");
    } else {
      cards.removeLast();
    }
    update();
  }
}
