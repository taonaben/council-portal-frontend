enum PaymentMethod { ecocash, oneMoney, omari, card, bankTransfer }

class PaymentAssets {
  static const String baseAssetPath = 'lib/assets/payments';

  static const Map<PaymentMethod, String> logos = {
    PaymentMethod.ecocash: '$baseAssetPath/ecocash.png',
    PaymentMethod.oneMoney: '$baseAssetPath/onemoney.jpg',
    PaymentMethod.omari: '$baseAssetPath/omari.png',
    PaymentMethod.card: '$baseAssetPath/card.png',
    PaymentMethod.bankTransfer: '$baseAssetPath/bank.png',
  };

  static const Map<PaymentMethod, String> names = {
    PaymentMethod.ecocash: 'EcoCash',
    PaymentMethod.oneMoney: 'OneMoney',
    PaymentMethod.omari: 'Omari',
    PaymentMethod.card: 'Card',
    PaymentMethod.bankTransfer: 'Bank Transfer',
  };
}
