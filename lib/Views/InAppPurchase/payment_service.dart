import 'dart:async';
import 'dart:io';
import 'package:new_fixera/Views/InAppPurchase/in_app_purchase_test.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/store_kit_wrappers.dart';
import 'package:new_fixera/Views/Utilities/AppRoutes.dart';
import 'package:new_fixera/Views/Utilities/AppUrl.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';



// Original code link: https://github.com/flutter/plugins/blob/master/packages/in_app_purchase/example/lib/main.dart

const bool kAutoConsume = true;

const String _kConsumableId1 = 'fixeracredit';
const String _kConsumableId2 = 'fixeramonth';
const List<String> _kProductIds = <String>[
  _kConsumableId1,
  _kConsumableId2];

// TODO: Please Add your android product ID here
const List<String> _kAndroidProductIds = <String>[
  ''
];


// TODO: Please Add your iOS product ID here
const List<String> _kiOSProductIds = <String>[
 'fixeracredit'
];
const List<String> _kiOSPackages = <String>[
  'fixeramonth'
];
//Example
//const List<String> _kiOSProductIds = <String>[
//  'ADD_YOUR_IOS_PRODUCT_ID_1',
//  'ADD_YOUR_IOS_PRODUCT_ID_2',
//  'ADD_YOUR_IOS_PRODUCT_ID_3'
//];
var duration ;
class MyPayApp extends StatefulWidget {
  bool? purchaseType = false;
  final String? packageID;
  final int? userID;


  MyPayApp({Key? key,  this.purchaseType, this.userID,  this.packageID}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyPayApp> {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
   var _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {

    DateTime currentDate = DateTime.now();
    DateTime noADDate;

    var fiftyDaysFromNow = currentDate.add(new Duration(days: 30));
    duration = fiftyDaysFromNow;
    print('Hlw BROOOOOOOOOOO +++++++++++++++++++++++++++++++++++${fiftyDaysFromNow.month} - ${fiftyDaysFromNow.day} - ${fiftyDaysFromNow.year} ${fiftyDaysFromNow.hour}:${fiftyDaysFromNow.minute}');

    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    print('Payment Service $isAvailable');

    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse =
    await _connection.queryProductDetails(Platform.isIOS ?  widget.purchaseType == true ?  _kiOSPackages.toSet() :  _kiOSProductIds.toSet() : _kAndroidProductIds.toSet());//_kProductIds.toSet());
    print('productDetailResponse ${productDetailResponse.productDetails[0].price}');
    if (productDetailResponse.error != null)
    {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isNotEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse =
    await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {
      // handle query past purchase error..
    }
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await _verifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }
    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = verifiedPurchases;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: [
            _buildConnectionCheckTile(),
            _buildProductList(),
          //  _buildConsumableBox(),

          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: const ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: widget.purchaseType == true ? Text('Buy Packages'):Text('Buy Credit') ,
          leading: GestureDetector(
            onTap: (){

             Get.toNamed(AppRoutes.BOTTOMNAVIGATIONPAGE) ;
            },
            child: Icon(Icons.arrow_back),
          ),
        ),

        body: Stack(
          children: stack,
        ),
      ),
    );
  }

  Card _buildConnectionCheckTile() {
    if (_loading) {
      return Card(child: ListTile(title: const Text('Trying to connect...')));
    }
    final Widget storeHeader = ListTile(
      leading: Icon(_isAvailable ? Icons.check : Icons.block,
          color: _isAvailable ? Colors.green : ThemeData.light().errorColor),
      title: Text(
          'The store is '  + (_isAvailable ? 'available' : 'unavailable') + '.'),
    );
    final List<Widget> children = <Widget>[storeHeader];

    if (!_isAvailable) {
      children.addAll([
        Divider(),
        ListTile(
          title: Text('Not connected',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: const Text(
              'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }

  Card _buildProductList() {
    // if (_loading) {
    //   return Card(
    //       child: (ListTile(
    //           leading: CircularProgressIndicator(),
    //           title: Text('Fetching products...'))));
    // }
    if (!_isAvailable) {
      return Card();
    }
    // final ListTile productHeader = ListTile(title: Text('Available Packages to be bought for Fixera!'));
    List<ListTile> productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verity the purchase data.
    Map<String, PurchaseDetails> purchases =
    Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    productList.addAll(_products.map(
          (ProductDetails productDetails) {
        PurchaseDetails? previousPurchase = purchases[productDetails.id];
        return ListTile(
            title: Text(
              productDetails.title,
            ),
            subtitle: Text(
              productDetails.description,
            ),
            trailing: widget.purchaseType == true ?  GestureDetector(
              child: Text('IF ${productDetails.price}'),

              onTap: () {
                PurchaseParam purchaseParam = PurchaseParam(
                    productDetails: productDetails);

                  _connection.buyConsumable(
                      purchaseParam: purchaseParam,
                      autoConsume: kAutoConsume || Platform.isIOS);

              },
            ) : GestureDetector(
              child: Text('Else ${productDetails.price}'),

              onTap: () {
                print('onPress ${productDetails.price}');
                print('onPress $kAutoConsume');
                PurchaseParam purchaseParam = PurchaseParam(
                    productDetails: productDetails);

                _connection.buyConsumable(
                    purchaseParam: purchaseParam);

              },
            )
        );
      },
    ));
//productHeader, add it in list
    return Card(

        child:
        Column(children: <Widget>[ ] + productList));
  }

  Card _buildConsumableBox() {
    if (_loading) {
      return Card(
          child: (ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching consumables...'))));
    }
    if (!_isAvailable || _notFoundIds.contains(_kConsumableId1)|| _notFoundIds.contains(_kConsumableId2)) {
      return Card();
    }


    final List<Widget> tokens = _consumables.map((String id) {
      return GridTile(
        child: IconButton(
          icon: Icon(
            Icons.stars,
            size: 42.0,
            color: Colors.orange,
          ),
          splashColor: Colors.yellowAccent,
          onPressed: () => consume(id),
        ),
      );
    }).toList();
    return Card(
        child: Column(children: <Widget>[

          Divider(),
          GridView.count(
            crossAxisCount: 5,
            children: tokens,
            shrinkWrap: true,
            padding: EdgeInsets.all(16.0),
          )
        ]));
  }

  Future<void> consume(String id) async {
    print('consume id is $id');
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    print('deliverProduct'); // Last
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId1||purchaseDetails.productID == _kConsumableId2) {
      await ConsumableStore.save(purchaseDetails!.purchaseID!);
      List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    print('_verifyPurchase');
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
    print('_handleInvalidPurchase');
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    print('_listenToPurchaseUpdated');
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      print('_listenToPurchaseUpdated ${purchaseDetails.status}');
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print("ERRRRRRRRRRRPRRRRRRRRORRRRRRRR+++++++++++++++++++++++++++++++++++!!!!111111111");
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if(widget.purchaseType == true ) {
            purchasePackageFromAppStore();
            print("package purchased");
            //
          } else {
            creditpurchaseFromAppStore();
            print("credit purchased");
          }

          if (valid) {
            deliverProduct(purchaseDetails);
            print("valid called+++++++++");
          } else {
            print("ERRRRRRRRRRRPRRRRRRRRORRRRRRRR+++++++++++++++++++++++++++++++++++!!!!111111111");
            _handleInvalidPurchase(purchaseDetails);
            print("_handleInvalidPurchase called ++++++");
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!kAutoConsume && purchaseDetails.productID == _kConsumableId1) {
            await InAppPurchaseConnection.instance
                .consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

  purchasePackageFromAppStore() async {
    String apiUrl = "https://www.fix-era.com/api/v1/packagePurchaseFromAppStore?package_id=${widget.packageID.toString()}&user_id=${widget.userID.toString()}";
    print("working 1111");

    final json = {
      "user_id": widget.userID.toString(),
      "package_id": widget.packageID.toString(),
    };

    http.Response response = await http.post(apiUrl, body: json);

    var jsonResponse = jsonDecode(response.body);
    print("My reposne is ++++++++++++$jsonResponse");

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      Get.offAndToNamed(AppRoutes.BOTTOMNAVIGATIONPAGE);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Congratulations. You have bought the package"),
        duration: Duration(milliseconds: 20000),
      ));
      return jsonDecode(response.body);

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Something error');
    }
  }



  creditpurchaseFromAppStore() async {
    String apiUrl = "https://www.fix-era.com/api/v1/creditPurchaseFromAppStore?user_id=${widget.userID.toString()}&purpose=job bidding&quantity=20";

    final json = {
      "user_id": widget.userID.toString(),
      "purpose": "Buying credit",
      "quantity" : "20"
    };

    http.Response response = await http.post(apiUrl, body: json);

    var jsonResponse = jsonDecode(response.body);
    print("My reposne is ++++++++++++$jsonResponse");
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      Get.offAndToNamed(AppRoutes.BOTTOMNAVIGATIONPAGE);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Congratulations. You have bought 20 credits"),
        duration: Duration(milliseconds: 2000),
      ));
      return jsonDecode(response.body);

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Something error');
    }
  }
}