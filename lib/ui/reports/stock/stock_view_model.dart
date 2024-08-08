import 'package:get/get.dart';
import 'package:order_booking/db/entities/route/route.dart';
import 'package:order_booking/ui/route/outlet/outlet_detail/outlet_detail_repository.dart';
import 'package:order_booking/utils/network_manager.dart';

import '../../../db/entities/packages/package.dart';
import '../../../db/entities/product/product.dart';
import '../../../db/entities/product_group/product_group.dart';
import '../../order/order_booking_repository.dart';

class StockViewModel extends GetxController {
  final OrderBookingRepository _orderBookingRepository;
  final OutletDetailRepository _detailRepository;

  final RxList<Package> _packages = RxList<Package>();
  final RxList<Product> filteredProducts = RxList<Product>();
  final RxList<ProductGroup> _productGroupList = RxList<ProductGroup>();
  final RxList<Product> _mutableProductList = RxList<Product>();
  Package? package;

  final RxBool _isSaving = false.obs;

  StockViewModel(this._orderBookingRepository, this._detailRepository);

  Future<void> init() async {
    _packages(await _orderBookingRepository.findAllPackages());
    _productGroupList(await _orderBookingRepository.findAllGroups());
    package = _packages.first;
    findAllProductsByPackageId(_packages.first.packageId);
    loadProducts();
  }

  void onProductsLoaded(List<Product> products, int? packageId) async {
    if (products.isNotEmpty) {
      products =
          await _orderBookingRepository.findAllProductsByPackage(packageId);
    }

    // Log.d("PackageId", products.size() + "After Size");

    _mutableProductList(products);
    setIsSaving(false);
  }

  void findAllProductsByPackageId(int? packageId) {
    _orderBookingRepository.findAllProductsByPackage(packageId).then(
          (products) => onProductsLoaded(products, packageId),
        );
  }

  RxList<Product> getProductList() => _mutableProductList;

  RxList<Package> getAllPackages() => _packages;

  RxList<ProductGroup> getAllProductGroups() => _productGroupList;

  void setIsSaving(bool value) {
    _isSaving(value);
    _isSaving.refresh();
  }
  void updateFilteredProducts(List<Product> products) {
    filteredProducts(products);
    filteredProducts.refresh();
  }


  void loadProducts() async {
    final bool isOnline =
        await NetworkManager.getInstance().isConnectedToInternet();

    if (isOnline) {
      _detailRepository.loadProductsFromServer().then((value) {
        _onStockLoadedFromServer();
      },);
    }
  }

  RxBool isLoading() {
    return _detailRepository.isLoading();
  }

  RxList<MRoute> getRoutes() {
    final RxList<MRoute> routeList = RxList();
   _detailRepository.getRoutes().then((routes) {
     routeList(routes);
   },);
    return routeList;
  }

  void _onStockLoadedFromServer() async{
    _packages(await _orderBookingRepository.findAllPackages());
    _productGroupList(await _orderBookingRepository.findAllGroups());
    package = _packages.first;
    findAllProductsByPackageId(_packages.first.packageId);
  }
}
