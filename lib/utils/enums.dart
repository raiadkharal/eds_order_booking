enum RequestStatus { LOADING, SUCCESS, ERROR }

enum ProductType { free, paid }

enum LimitBy {
  quantity, // Implicit assignment of 0
  amount, // Implicit assignment of 1 (since quantity is 0)
}

enum AccessSequenceCode {
  DISTRIBUTION_PRODUCT,
  OUTLET_PRODUCT,
  ROUTE_PRODUCT,
  REGION_PRODUCT,
  PRODUCT,
  OUTLET,
  ROUTE,
  DISTRIBUTION;
}

enum ScaleBasis {
  Quantity,
  Value,
  Total_Quantity,
}

enum MessageSeverityLevel {
  ERROR,
  WARNING,
  MESSAGE,
}

enum CalculationType {
  Fix,
  Percentage,
}

enum OperationType {
  Plus,
  Minus,
}

enum RoundingRule {
  Zero_Decimal_Precision,
  Two_Decimal_Precision ,
  Floor,
  Ceiling ,
}

enum EnumPCDefinitionLevel {
  ProductLevel,
  PackageLevel,
}

enum EnumFreeGoodsQuantityType
{
 Primary,
 Optional,
}

enum EnumFreeGoodsType
{
  Inclusive,
  Exclusive,
}