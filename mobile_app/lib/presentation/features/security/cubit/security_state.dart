part of 'security_cubit.dart';

@freezed
abstract class SecurityState with _$SecurityState {
  const factory SecurityState({
    @Default(SecurityView()) SecurityView view,

    /// No connection: a run that failed says "You're offline".
    @Default(false) bool offline,
  }) = _SecurityState;
}
