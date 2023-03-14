import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/NormalAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class VendorEstimation extends StatefulWidget {
  VendorEstimation({Key? key}) : super(key: key);

  @override
  _VendorEstimationState createState() => _VendorEstimationState();
}

class _VendorEstimationState extends State<VendorEstimation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Estimation"),),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Container(
                height: Get.height / 4,
                width: Get.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 32),
                    Container(
                      color: Colors.black,
                      height: 150,
                      width: 0.8,
                    ),
                    SizedBox(width: 32),
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
                  ],
                )),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Excepteur sint occaecat cupidatat non proident, saeunt in culpa qui offici adeserunt mollit anim laborum. Seden utem perspiciatis undesieu omnisvoluptatem accusantium doque laudantium, totam rem aiam eaqueiu ipsaquae ab illoion inventore veritatisetm quasitea architecto beataea dictaedquia couuntur magni dolores eos aquist ratione vtatem seque nesnt. Nequeporro quamest quioremas ipsum quiatem dolor sitem ameteism concteturadipisci velit sedate quianon.",
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Laborum sed ut perspiciatis unde omnis iste natus error sitems voluptate maccusantium doloremque laudantium, totam rem aiam eaque ipsa quaeab illo inventore veritatis etna quasi architecto beatae vitae dictationexplicabo. nemo enim ipsam fugit",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 40,
                width: Get.width,
                color: AppColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text("Type 1-20%"),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Description"),
                  Text("Qty"),
                  Text("Unit"),
                  Text("Unit Price"),
                  Text("Price"),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              indent: 24,
              endIndent: 24,
              height: 2,
              thickness: 2,
              color: AppColors.textColorBlack,
            ),
            SizedBox(
              height: 16,
            ),
            //so much confusion in this area

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "When price agreeable is determined it shall become the final contract priceand owner/GC authorizes X Contractor to obtain labor and material inaccordance with the price agreeable and the specifications set out hereinand on the hereof to accomplish the replacement or repair. By signing agreement, you acknowledge all terms listed on this agreement includingthe reverse.",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Text(
                    "Scope of work to include",
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Checks must be made payable to: 365 Restoration Services:",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Payment Schedule: 50% down (for material) and 50% at completion.",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "ANY ADDITIONAL COST WILL BE SUBMITTED IN WRITTEN ON A CHANGE ORDER",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.VENDORESTIMATION);
              },

              child: Text(
                'Sent Estimation',
                style: TextStyle(
                  color: AppColors.textColorBlack,
                  fontSize: Dimension.text_size_Semi_small,
                ),
              ),
            ),
          ],
        ),
      )),
    ));
  }
}
