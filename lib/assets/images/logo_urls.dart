enum PaymentMethod { ecocash, oneMoney, omari, visa, masterCard, bankTransfer }

class PaymentAssets {
  static const String baseAssetPath = 'assets/images/payments';

  static const Map<PaymentMethod, String> logos = {
    PaymentMethod.ecocash: '$baseAssetPath/ecocash.png',
    PaymentMethod.oneMoney: '$baseAssetPath/onemoney.png',
    PaymentMethod.omari: '$baseAssetPath/omari.png',
    PaymentMethod.visa: '$baseAssetPath/visa.png',
    PaymentMethod.masterCard: '$baseAssetPath/mastercard.png',
    PaymentMethod.bankTransfer: '$baseAssetPath/bank.png',
  };

  static const Map<PaymentMethod, String> names = {
    PaymentMethod.ecocash: 'EcoCash',
    PaymentMethod.oneMoney: 'OneMoney',
    PaymentMethod.omari: 'Omari',
    PaymentMethod.visa: 'Visa',
    PaymentMethod.masterCard: 'MasterCard',
    PaymentMethod.bankTransfer: 'Bank Transfer',
  };
}
