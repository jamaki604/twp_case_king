class Revision {
  final String _userName;
  final String _timeStamp;

  Revision(this._userName, this._timeStamp);

  String get timeStamp {
    return _timeStamp;
  }

  String get username {
    return _userName;
  }

}