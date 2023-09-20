// import 'package:credit_card_scanner/credit_card_scanner.dart';
// import 'package:flutter/material.dart';

// class CardScannerService {
//   static String? _cardHolderName;
//   static String? _cardNumber;
//   static String? _carDate;

//   static String? get cardHolderName => _cardHolderName;
//   static String? get cardNumber => _cardNumber;
//   static String? get cardDate => _carDate;

//   static bool fieldsAreNotNull() {
//     if (_carDate != null && _cardHolderName != null && cardNumber != null) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   static Future<void> scanCard() async {
//     CardScanner.scanCard();
//     CardDetails? cardDetails = await CardScanner.scanCard(
//         scanOptions: const CardScanOptions(
//       scanExpiryDate: true,
//       scanCardHolderName: true,
//     ));

//     if (cardDetails != null) {
//       _cardHolderName = cardDetails.cardHolderName;
//       _carDate = cardDetails.expiryDate;
//       _cardHolderName = cardDetails.cardNumber;
//     } else {
//       debugPrint("KARTA TOPILMADI");
//     }
//   }
// }
