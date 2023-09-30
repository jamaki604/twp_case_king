import 'package:twp_case_king/redirect.dart';
import 'package:twp_case_king/revision.dart';

class ParseResult {
  final List<Revision> _revisions;
  final Redirect? _redirect;
  bool pageExists;

  ParseResult(this._revisions, this._redirect, this.pageExists);



  Redirect? get redirect => _redirect;

  List<Revision> get revisions => _revisions;
}
