class ReportModel {
  double carton;
  double cartonConfirm;
  double grandTotal;
  double grandTotalConfirm;
  int skuSize;
  double totalSku;
  int totalOrders;
  int totalConfirmOrders;
  int syncCount;

  int pjpCount;
  int completedOutletsCount;
  int productiveOutletCount;
  int pendingCount;

  ReportModel({
    this.carton = 0.0,
    this.cartonConfirm = 0.0,
    this.grandTotal = 0.0,
    this.grandTotalConfirm = 0.0,
    this.skuSize = 0,
    this.totalSku = 0.0,
    this.totalOrders = 0,
    this.totalConfirmOrders = 0,
    this.syncCount = 0,
    this.pjpCount = 0,
    this.completedOutletsCount = 0,
    this.productiveOutletCount = 0,
    this.pendingCount = 0,
  });

  int getSyncCount() {
    return syncCount;
  }

  void setSyncCount(int syncCount) {
    this.syncCount = syncCount;
  }

  double getCarton() {
    return carton;
  }

  void setCarton(double carton) {
    this.carton = carton;
  }

  int getTotalConfirmOrders() {
    return totalConfirmOrders;
  }

  void setTotalConfirmOrders(int totalConfirmOrders) {
    this.totalConfirmOrders = totalConfirmOrders;
  }

  double getCartonConfirm() {
    return cartonConfirm;
  }

  void setCartonConfirm(double cartonConfirm) {
    this.cartonConfirm = cartonConfirm;
  }

  double getTotalAmount() {
    return grandTotal;
  }

  void setTotalSale(double totalAmount) {
    grandTotal = totalAmount;
  }

  double getTotalAmountConfirm() {
    return grandTotalConfirm;
  }

  void setTotalSaleConfirm(double totalAmount) {
    grandTotalConfirm = totalAmount;
  }

  int getTotalOrders() {
    return totalOrders;
  }

  int getSkuSize() {
    return skuSize;
  }

  double getAvgSkuSize() {
    if (getProductiveOutletCount() < 1) return 0;
    return skuSize / getProductiveOutletCount();
  }

  double getDropSize() {
    if (getProductiveOutletCount() < 1) return 0.0;
    return getTotalAmount() / getProductiveOutletCount();
  }

  void setSkuSize(int skuSize) {
    this.skuSize = skuSize;
  }

  int getPjpCount() {
    return pjpCount;
  }

  void setPjpCount(int pjpCount) {
    this.pjpCount = pjpCount;
  }

  void setCounts(int pjpCount, int completedTaskCount, int productiveOutletCount, int pendingCount) {
    this.pjpCount = pjpCount;
    completedOutletsCount = completedTaskCount;
    this.productiveOutletCount = productiveOutletCount;
    this.pendingCount = pendingCount;
  }

  int getCompletedOutletsCount() {
    return completedOutletsCount;
  }

  void setCompletedOutletsCount(int completedTaskCount) {
   completedOutletsCount = completedTaskCount;
  }

  int getProductiveOutletCount() {
    return productiveOutletCount;
  }

  double getTotalSku() {
    return totalSku;
  }

  void setTotalSku(double totalSku) {
    this.totalSku = totalSku;
  }

  void setProductiveOutletCount(int productiveOutletCount) {
    this.productiveOutletCount = productiveOutletCount;
  }

  int getPendingCount() {
    return pendingCount;
  }

  void setPendingCount(int pendingCount) {
    this.pendingCount = pendingCount;
  }

  void setTotalOrders(int totalOrders) {
    this.totalOrders = totalOrders;
  }
}
