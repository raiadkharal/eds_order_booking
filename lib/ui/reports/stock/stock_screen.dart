import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/components/progress_dialog/PregressDialog.dart';
import 'package:order_booking/db/entities/packages/package.dart';
import 'package:order_booking/db/entities/route/route.dart';
import 'package:order_booking/ui/reports/stock/stock_list_item.dart';
import 'package:order_booking/ui/reports/stock/stock_view_model.dart';
import 'package:order_booking/ui/route/outlet/outlet_detail/outlet_detail_repository.dart';

import '../../../components/button/cutom_button.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Constants.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final StockViewModel _controller = Get.put<StockViewModel>(StockViewModel(
    Get.find(),
    OutletDetailRepository(
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find()),
  ));

  RxString tvRoutes = "".obs;

  @override
  void initState() {
    super.initState();

    _controller.init();
    _setObservers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "Stock Report",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 2, right: 2),
                child: Card(
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            tvRoutes.value,
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 2, right: 2),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Package Name: ",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                            child: Theme(
                          data: Theme.of(context)
                              .copyWith(canvasColor: Colors.white),
                          child: Obx(
                            () => DropdownButtonFormField(
                              onChanged: (value) {
                                _controller.package = value as Package;
                                _controller.findAllProductsByPackageId(
                                    _controller.package?.packageId);
                              },
                              isDense: true,
                              isExpanded: true,
                              value: _controller.getAllPackages().isNotEmpty
                                  ? _controller.getAllPackages()[0]
                                  : "No Packages",
                              decoration: const InputDecoration(
                                isCollapsed: true,
                                contentPadding: EdgeInsets.all(5),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                              items: _controller
                                  .getAllPackages()
                                  .map(
                                    (package) => DropdownMenuItem(
                                        value: package,
                                        child: Text(
                                          package.packageName.toString(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  )
                                  .toList(),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Card(
                  elevation: 3,
                  color: secondaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "Name",
                              style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Wh Stock",
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: Obx(
                  () => ListView.builder(
                    itemBuilder: (context, index) {
                      return StockListItem(
                        product: _controller.filteredProducts[index],
                      );
                    },
                    itemCount: _controller.filteredProducts.length,
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: "Close"),
              )
            ],
          ),
          Obx(
            () => _controller.isLoading().value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  void _setObservers() {
    debounce(_controller.getRoutes(), (routeList) {
      _onRoutesLoaded(routeList);
    }, time: const Duration(milliseconds: 200));

    debounce(_controller.getProductList(), (products) {
      _controller.updateFilteredProducts(products);
    }, time: const Duration(milliseconds: 100));
  }

  void _onRoutesLoaded(List<MRoute> routeList) {
    String routeDesc = "";
    for (MRoute route in routeList) {
      routeDesc += ("${route.routeName} ${routeList.length > 1 ? "\n" : ""}");
    }
    tvRoutes(routeDesc);
  }
}
