// /// Creating the  Details Class
// class Details {
//   /// Specifies the Payee Address or the business virtual payment address (VPA) i.e Payee  ID
//   ///
//   /// The [ID] property is required to transfer the amount to the Payee  ID
//   ///
//   final String ID;

//   /// Specifies the Payee Name or the Business Name
//   ///
//   /// The [payeeName] property is required so as to cross verify the payeename with  ID,
//   /// so to check the transaction is valid or not
//   final String payeeName;

//   /// Defines the transaction ID
//   ///
//   /// The [transactionID] property is optional, you can specify the transaction id or else not
//   ///
//   /// Default value is empty String
//   ///
//   final String? transactionID;

//   /// Defines the amount to be transferred to the Payee 
//   ///
//   /// The [amount] property is required, you need to specify the amount you going to transfer
//   ///
//   final double? amount;

//   /// Defines the code of the currency.
//   ///
//   /// The [currencyCode] is just optional Default Code is INR
//   ///
//   final String currencyCode;

//   /// Defines the Note to view to the payee when you are paying.
//   ///
//   /// The [transactionNote] is justion optional, Default value is empty String
//   ///
//   final String? transactionNote;

//   Details(
//       {required this.ID,
//       required this.payeeName,
//       this.transactionID = "",
//       this.amount = 0,
//       this.currencyCode = "INR",
//       this.transactionNote = ""});

//   String get qrCodeValue {
//     if (amount == null) {
//       return "://pay?pa=$ID&pn=$payeeName&tr=$transactionID&cu=$currencyCode&mc=0000&mode=02&purpose=00&tn=$transactionNote&tr=$transactionID";
//     }
//     return "://pay?pa=$ID&pn=$payeeName&tr=$transactionID&am=$amount&cu=$currencyCode&mc=0000&mode=02&purpose=00&tn=$transactionNote&tr=$transactionID";
//   }
// }
