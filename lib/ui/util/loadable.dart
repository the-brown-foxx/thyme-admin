sealed class Loadable<T> {
  const Loadable();

  Loadable<R> map<R>(final R Function(T) transform) {
    final loadable = this;
    return loadable is Loaded<T>
        ? Loaded(transform(loadable.value))
        : Loading<R>();
  }
}

class Loading<T> extends Loadable<T> {
  const Loading();
}

class Loaded<T> extends Loadable<T> {
  final T value;

  const Loaded(this.value);
}
