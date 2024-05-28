class SqlQueries {
  static const String createAssetTable = '''
CREATE TABLE IF NOT EXISTS Asset (
  assetId INTEGER PRIMARY KEY,
  outletId INTEGER,
  organizationId INTEGER,
  assetTypeMainId INTEGER,
  longitude REAL,
  latitude REAL,
  assetModel TEXT,
  assetModelId INTEGER,
  assetName TEXT,
  assetNumber TEXT,
  assetType TEXT,
  assetTypeId INTEGER,
  assignedDate INTEGER,
  assignmentCode TEXT,
  cost REAL,
  deposit REAL,
  documentNumber TEXT,
  statusid INTEGER,
  expiryDate INTEGER,
  returnDate INTEGER,
  barcode TEXT,
  transactionType TEXT,
  reason TEXT,
  verified BOOLEAN
);
''';

  static const String createAvailableStockTable = '''
CREATE TABLE IF NOT EXISTS AvailableStock (
  pk_modid INTEGER PRIMARY KEY AUTOINCREMENT,
  productId INTEGER,
  packageId INTEGER,
  unitProductDefinitionId INTEGER,
  cartonProductDefinitionId INTEGER,
  orderId INTEGER,
  outletId INTEGER,
  cartonQuantity INTEGER ,
  unitQuantity INTEGER
);
''';

  static const String createCartonPriceBreakDownTable = '''
CREATE TABLE IF NOT EXISTS CartonPriceBreakDown (
  pk_cpbd INTEGER PRIMARY KEY AUTOINCREMENT,
  fk_modid INTEGER NOT NULL,
  orderId INTEGER,
  priceCondition TEXT,
  priceConditionType TEXT,
  priceConditionClass TEXT,
  priceConditionClassOrder INTEGER,
  priceConditionId INTEGER,
  priceConditionDetailId INTEGER,
  accessSequence TEXT,
  unitPrice REAL,
  blockPrice REAL,
  totalPrice REAL,
  calculationType INTEGER,
  outletId INTEGER,
  productId INTEGER,
  productDefinitionId INTEGER,
  isMaxLimitReached INTEGER,
  maximumLimit REAL,
  alreadyAvailed REAL,
  limitBy INTEGER,
  FOREIGN KEY (mobileOrderDetailId) REFERENCES OrderDetail (pk_modid) ON DELETE CASCADE,
  INDEX (mobileOrderDetailId)
);
''';

  static const String createCustomerInputTable = '''
CREATE TABLE IF NOT EXISTS CustomerInput (
  outletId INTEGER NOT NULL,
  orderId INTEGER NOT NULL,
  mobileNumber TEXT,
  strn TEXT,
  remarks TEXT,
  signature TEXT,
  cnic TEXT,
  deliveryDate INTEGER NOT NULL,
  PRIMARY KEY (outletId, orderId)
);
''';

  static const String createAssetStatusTable = '''
CREATE TABLE IF NOT EXISTS AssetStatus (
  key INTEGER,
  value TEXT,
  description TEXT,
  firstIntExtraField INTEGER,
  firstStringExtraField TEXT,
  defaultFlag INTEGER,
  secondIntExtraField INTEGER,
  secondStringExtraField TEXT,
  hasError INTEGER,
  errorMessage TEXT,
  PRIMARY KEY (key)
);
''';
  static const String createMarketReturnReasonTable = '''
CREATE TABLE IF NOT EXISTS MarketReturnReason (
  id INTEGER PRIMARY KEY,
  marketReturnReason TEXT,
  returnedProductTypeId INTEGER
);
''';

  static const String createLookUpTable = '''
CREATE TABLE IF NOT EXISTS LookUp (
  lookUpId INTEGER PRIMARY KEY AUTOINCREMENT,
  assetStatus TEXT, -- Assuming you'll convert it to JSON before saving in DB
  marketReturnReasons TEXT -- Assuming you'll convert it to JSON before saving in DB
);
''';

  static const String createMarketReturnDetailsTable = '''
CREATE TABLE IF NOT EXISTS MarketReturnDetails (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  outletId INTEGER,
  productId INTEGER,
  unitDefinitionId INTEGER,
  cartonDefinitionId INTEGER,
  replacementProductId INTEGER,
  replacementUnitDefinitionId INTEGER,
  replacementCartonDefinitionId INTEGER,
  marketReturnReasonId INTEGER,
  invoiceId INTEGER,
  cartonQuantity INTEGER,
  unitQuantity INTEGER,
  replaceWith TEXT,
  replacementCartonQuantity INTEGER,
  replacementUnitQuantity INTEGER,
  cartonSize INTEGER,
  replacementCartonSize INTEGER
);
''';
  static const String createMarketReturnsTable = '''
CREATE TABLE IF NOT EXISTS MarketReturns (
  outletId INTEGER PRIMARY KEY,
  invoiceId INTEGER,
);
''';
  static const String createMerchandiseTable = '''
CREATE TABLE IF NOT EXISTS Merchandise (
    outletId INTEGER PRIMARY KEY,
    remarks TEXT,
    merchandiseImages TEXT,
    assets TEXT
);
''';

  static const String createOrderTable = '''
CREATE TABLE IF NOT EXISTS Order (
  pk_oid INTEGER PRIMARY KEY AUTOINCREMENT,
  c_outletId INTEGER,
  serverOrderId INTEGER,
  routeId INTEGER,
  orderStatusId INTEGER,
  visitDayId INTEGER,
  latitude REAL,
  longitude REAL,
  orderDate INTEGER,
  deliveryDate INTEGER,
  distributionId INTEGER,
  priceBreakDown TEXT,
  orderDetails TEXT,
  FOREIGN KEY(c_outletId) REFERENCES Outlet(mOutletId) ON DELETE CASCADE,
  INDEX(c_outletId)
);
''';

  static const String createOrderDetailTable = '''
 CREATE TABLE IF NOT EXISTS UnitPriceBreakDown (
  pk_upbd INTEGER PRIMARY KEY AUTOINCREMENT,
  mOrderId INTEGER,
  fk_modid INTEGER,
  mPriceCondition TEXT,
  mPriceConditionType TEXT,
  mPriceConditionClass TEXT,
  mPriceConditionClassOrder INTEGER,
  mPriceConditionClassId INTEGER,
  mPriceConditionId INTEGER,
  mPriceConditionDetailId INTEGER,
  mAccessSequence TEXT,
  mUnitPrice REAL,
  mBlockPrice REAL,
  mTotalPrice REAL,
  mCalculationType INTEGER,
  outletId INTEGER,
  mProductId INTEGER,
  mProductDefinitionId INTEGER,
  isMaxLimitReached INTEGER,
  maximumLimit REAL,
  mAlreadyAvailed REAL,
  mLimitBy INTEGER,
  FOREIGN KEY (fk_modid) REFERENCES OrderDetail(pk_modid) ON DELETE CASCADE
);

  ''';

  static const String createOrderStatusTable = '''
  CREATE TABLE IF NOT EXISTS OrderStatus (
    outletId INTEGER PRIMARY KEY NOT NULL,
    orderId INTEGER,
    outletVisitEndTime INTEGER,
    outletVisitStartTime INTEGER,
    status INTEGER,
    orderAmount REAL,
    sync INTEGER,
    data TEXT,
    imageStatus INTEGER,
    requestStatus INTEGER DEFAULT 0,
    outletLatitude REAL,
    outletLongitude REAL,
    outletDistance INTEGER,
    FOREIGN KEY (outletId) REFERENCES Outlet(mOutletId) ON DELETE CASCADE
);
''';

  static const String createOutletTable = '''
  CREATE TABLE IF NOT EXISTS Outlet (
    mOutletId INTEGER PRIMARY KEY,
    mRouteId INTEGER,
    mOutletCode TEXT,
    mOutletName TEXT,
    mChannelName TEXT,
    mLocation TEXT,
    mVisitFrequency INTEGER,
    mVisitDay INTEGER,
    planned INTEGER,
    sequenceNumber INTEGER,
    mAddress TEXT,
    mLatitude REAL,
    mLongitude REAL,
    visitTimeLat REAL,
    visitTimeLng REAL,
    mLastSaleDate INTEGER,
    pricingGroupId INTEGER,
    vpoClassificationId INTEGER,
    channelId INTEGER,
    mLastSaleQuantity TEXT,
    mAvailableCreditLimit REAL,
    mOutstandingCredit REAL,
    mLastSale REAL,
    mVisitStatus INTEGER,
    cnic TEXT,
    strn TEXT,
    mtdSale REAL,
    mobileNumber TEXT,
    hasHTHDiscount INTEGER,
    hasRentalDiscount INTEGER,
    hasExclusivityFee INTEGER,
    lastOrder TEXT, -- Serialized as TEXT for simplicity
    isAssetsScennedInTheLastMonth INTEGER,
    synced INTEGER,
    statusId INTEGER,
    isZeroSaleOutlet INTEGER,
    promoTypeId INTEGER,
    customerRegistrationTypeId INTEGER,
    digitalAccount TEXT,
    disburseAmount REAL,
    remarks TEXT,
    organizationId INTEGER,
    outletPromoConfigId INTEGER,
    outletVisits TEXT, -- Serialized as TEXT for simplicity
    avlStockDetail TEXT -- Serialized as TEXT for simplicity
);
''';

  static const String createOutletAvailedPromotionTable = '''
CREATE TABLE IF NOT EXISTS OutletAvailedPromotion (
  id INTEGER PRIMARY KEY,
  outletId INTEGER,
  priceConditionId INTEGER,
  priceConditionDetailId INTEGER,
  quantity INTEGER,
  amount REAL,
  productId INTEGER,
  productDefinitionId INTEGER,
  packageId INTEGER
);
''';

  static const String createPackageTable = '''
  CREATE TABLE IF NOT EXISTS Package (
    packageId INTEGER PRIMARY KEY,
    packageName TEXT
);
''';

  static const String createProductTable = '''
  CREATE TABLE IF NOT EXISTS Product (
    pk_pid INTEGER PRIMARY KEY,
    productId INTEGER,
    productName TEXT,
    productDescription TEXT,
    productCode TEXT,
    productGroupId INTEGER,
    productGroupName TEXT,
    productPackageId INTEGER,
    packageName TEXT,
    productBrandId INTEGER,
    brandName TEXT,
    productFlavorId INTEGER,
    flavorName TEXT,
    unitCode TEXT,
    cartonCode TEXT,
    unitQuantity INTEGER,
    cartonQuantity INTEGER,
    unitSizeForDisplay TEXT,
    cartonSizeForDisplay TEXT,
    unitStockInHand INTEGER,
    cartonStockInHand INTEGER,
    unitDefinitionId INTEGER,
    cartonDefinitionId INTEGER,
    actualUnitStock INTEGER,
    actualCartonStock INTEGER
);
''';

  static const String createProductGroupTable = '''
  CREATE TABLE IF NOT EXISTS product_groups (
    productGroupId INTEGER PRIMARY KEY,
    productGroupName TEXT
);
''';


  static const String createPromotionTable = '''
  CREATE TABLE IF NOT EXISTS promotions (
    promotionId INTEGER PRIMARY KEY AUTOINCREMENT,
    outletId INTEGER,
    priceConditionId INTEGER,
    detailId INTEGER,
    name TEXT,
    amount REAL,
    calculationType TEXT,
    freeGoodId INTEGER,
    freeGoodName TEXT,
    freeGoodSize TEXT,
    size TEXT,
    promoOrFreeGoodType TEXT,
    freeGoodQuantity INTEGER
);
''';

  static const String createRouteTable = '''
  CREATE TABLE IF NOT EXISTS routes (
    routeId INTEGER PRIMARY KEY,
    routeName TEXT,
    employeeId INTEGER,
    totalOutlets INTEGER
);
''';

  static const String createTaskTable = '''
  CREATE TABLE IF NOT EXISTS tasks (
    taskId INTEGER NOT NULL,
    taskTypeId INTEGER NOT NULL,
    taskName TEXT,
    taskDate TEXT,
    outletId INTEGER,
    completedDate TEXT,
    status TEXT,
    remarks TEXT,
    PRIMARY KEY (taskId, taskTypeId)
);
''';

  static const String createFreeGoodsDetailTable = '''
  CREATE TABLE IF NOT EXISTS FreeGoodsDetail (
    freeGoodDetailId INTEGER PRIMARY KEY NOT NULL,
    freeGoodMasterId INTEGER,
    productId INTEGER,
    productCode TEXT,
    productName TEXT,
    productDefinitionId INTEGER,
    typeId INTEGER,
    typeText TEXT,
    minimimQuantity INTEGER,
    forEachQuantity INTEGER,
    freeGoodQuantity INTEGER,
    freeGoodGroupId INTEGER,
    maximumFreeGoodQuantity INTEGER,
    startDate TEXT,
    endDate TEXT,
    isActive INTEGER,
    status TEXT,
    isDifferentProduct INTEGER
);
''';

  static const String createFreeGoodsExclusivesTable = '''
  CREATE TABLE IF NOT EXISTS FreeGoodExclusives (
    freeGoodExclusiveId INTEGER PRIMARY KEY NOT NULL,
    freeGoodGroupId INTEGER,
    productId INTEGER,
    productCode TEXT,
    productName TEXT,
    productDefinitionId INTEGER,
    quantity INTEGER,
    maximumFreeGoodQuantity INTEGER,
    offerType TEXT,
    status TEXT,
    isDeleted INTEGER
);
''';
}
