enum AsyncValueState { loading, success, error }

class AsyncValue<T> {
  T? data;
  Object? error;
  AsyncValueState state;

  AsyncValue.loading() : state = AsyncValueState.loading;

  AsyncValue.success(this.data) : state = AsyncValueState.success;

  AsyncValue.error(this.error) : state = AsyncValueState.error;
}