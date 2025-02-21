abstract class IBaseFactory<T> {
  void isValid(T instance);
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T instance);
}