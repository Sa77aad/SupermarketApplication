class ChecklistDetails {
  int cdBarcode;
  int cdQuantity;
  String cdSupermarket;

  ChecklistDetails(this.cdBarcode, this.cdQuantity, this.cdSupermarket);

  int get barcode => cdBarcode;

  set barcode(int value) {
    cdBarcode = value;
  }

  int get quantity => cdQuantity;

  set quantity(int value) {
    cdQuantity = value;
  }

  String get supermarket => cdSupermarket;

  set supermarket(String value) {
    cdSupermarket = value;
  }
}
