class Revision {
  final String _userName;
  final DateTime _timeStamp;


  Revision(this._userName, this._timeStamp);

  String get timeStamp {
    return _timeStamp.toIso8601String();
  }


  String get username {
    return _userName;
  }

}