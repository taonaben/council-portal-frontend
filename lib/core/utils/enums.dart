
enum DocumentType {
  invoice,
  contract,
  receipt,
  other
}

enum DocumentSource {
  inHouse,
  client
}

enum PaymentStatus {
  pending,
  paid,
  overdue,
  cancelled
}

enum ContractStatus {
  draft,
  active,
  expired,
  terminated
}

enum ReceiptCategory {
  animal,
  crop,
  eggs,
  assets,
  other
}