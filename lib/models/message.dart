class Message {
  final String idForm;
  final String idTo;
  final String timesTamp;
  final String contnent;
  final int type;

  Message(this.idForm, this.idTo, this.timesTamp, this.contnent, this.type);

  Map<String, dynamic> toHashMap() {
    return {
      'idForm': idForm,
      'idTo': idTo,
      'timesTamp': timesTamp,
      'tpe': type
    };
  }
}
