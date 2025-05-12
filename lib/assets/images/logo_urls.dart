enum PaymentMethod { ecocash, oneMoney, card, bankTransfer }

class PaymentAssets {
  static const String baseAssetPath = 'lib/assets/payments';

  static const Map<PaymentMethod, String> logos = {
    PaymentMethod.ecocash: '$baseAssetPath/ecocash.png',
    PaymentMethod.oneMoney: '$baseAssetPath/onemoney.jpg',
    PaymentMethod.card: '$baseAssetPath/card.png',
    PaymentMethod.bankTransfer: '$baseAssetPath/bank.png',
  };

  static const Map<PaymentMethod, String> names = {
    PaymentMethod.ecocash: 'EcoCash',
    PaymentMethod.oneMoney: 'OneMoney',
    PaymentMethod.card: 'Card',
    PaymentMethod.bankTransfer: 'Bank Transfer',
  };
}
