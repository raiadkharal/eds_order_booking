
class Event<T> {
  bool _hasBeenHandled = false;
  final T _content;

  Event(this._content);

  bool get hasBeenHandled => _hasBeenHandled;

  T? getContentIfNotHandled() {
    T? object;
    if (_hasBeenHandled) {
      object = null;
    } else {
      _hasBeenHandled = true;
      object = _content;
    }

    return object;
  }

  T peekContent() {
    return _content;
  }
}
