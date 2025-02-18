class TransactionList {
    int ?transactionId;
    double amount;
    int ?clientId;

    TransactionList({
         this.transactionId,
        required this.amount,
         this.clientId,
    });

    factory TransactionList.fromJson(Map<String, dynamic> json) => TransactionList(
        transactionId: json["transactionId"],
        amount: json["amount"],
        clientId: json["client_id"],
    );

    Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "amount": amount,
        "client_id": clientId,
    };
}