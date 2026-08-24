// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_media_ranking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotMediaRanking {

 List<RankedMediaItem> get female; List<RankedMediaItem> get male; List<RankedMediaItem> get alien;
/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotMediaRankingCopyWith<SpotMediaRanking> get copyWith => _$SpotMediaRankingCopyWithImpl<SpotMediaRanking>(this as SpotMediaRanking, _$identity);

  /// Serializes this SpotMediaRanking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotMediaRanking&&const DeepCollectionEquality().equals(other.female, female)&&const DeepCollectionEquality().equals(other.male, male)&&const DeepCollectionEquality().equals(other.alien, alien));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(female),const DeepCollectionEquality().hash(male),const DeepCollectionEquality().hash(alien));

@override
String toString() {
  return 'SpotMediaRanking(female: $female, male: $male, alien: $alien)';
}


}

/// @nodoc
abstract mixin class $SpotMediaRankingCopyWith<$Res>  {
  factory $SpotMediaRankingCopyWith(SpotMediaRanking value, $Res Function(SpotMediaRanking) _then) = _$SpotMediaRankingCopyWithImpl;
@useResult
$Res call({
 List<RankedMediaItem> female, List<RankedMediaItem> male, List<RankedMediaItem> alien
});




}
/// @nodoc
class _$SpotMediaRankingCopyWithImpl<$Res>
    implements $SpotMediaRankingCopyWith<$Res> {
  _$SpotMediaRankingCopyWithImpl(this._self, this._then);

  final SpotMediaRanking _self;
  final $Res Function(SpotMediaRanking) _then;

/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? female = null,Object? male = null,Object? alien = null,}) {
  return _then(_self.copyWith(
female: null == female ? _self.female : female // ignore: cast_nullable_to_non_nullable
as List<RankedMediaItem>,male: null == male ? _self.male : male // ignore: cast_nullable_to_non_nullable
as List<RankedMediaItem>,alien: null == alien ? _self.alien : alien // ignore: cast_nullable_to_non_nullable
as List<RankedMediaItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotMediaRanking].
extension SpotMediaRankingPatterns on SpotMediaRanking {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotMediaRanking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotMediaRanking() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotMediaRanking value)  $default,){
final _that = this;
switch (_that) {
case _SpotMediaRanking():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotMediaRanking value)?  $default,){
final _that = this;
switch (_that) {
case _SpotMediaRanking() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RankedMediaItem> female,  List<RankedMediaItem> male,  List<RankedMediaItem> alien)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotMediaRanking() when $default != null:
return $default(_that.female,_that.male,_that.alien);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RankedMediaItem> female,  List<RankedMediaItem> male,  List<RankedMediaItem> alien)  $default,) {final _that = this;
switch (_that) {
case _SpotMediaRanking():
return $default(_that.female,_that.male,_that.alien);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RankedMediaItem> female,  List<RankedMediaItem> male,  List<RankedMediaItem> alien)?  $default,) {final _that = this;
switch (_that) {
case _SpotMediaRanking() when $default != null:
return $default(_that.female,_that.male,_that.alien);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotMediaRanking implements SpotMediaRanking {
  const _SpotMediaRanking({required final  List<RankedMediaItem> female, required final  List<RankedMediaItem> male, required final  List<RankedMediaItem> alien}): _female = female,_male = male,_alien = alien;
  factory _SpotMediaRanking.fromJson(Map<String, dynamic> json) => _$SpotMediaRankingFromJson(json);

 final  List<RankedMediaItem> _female;
@override List<RankedMediaItem> get female {
  if (_female is EqualUnmodifiableListView) return _female;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_female);
}

 final  List<RankedMediaItem> _male;
@override List<RankedMediaItem> get male {
  if (_male is EqualUnmodifiableListView) return _male;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_male);
}

 final  List<RankedMediaItem> _alien;
@override List<RankedMediaItem> get alien {
  if (_alien is EqualUnmodifiableListView) return _alien;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alien);
}


/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotMediaRankingCopyWith<_SpotMediaRanking> get copyWith => __$SpotMediaRankingCopyWithImpl<_SpotMediaRanking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotMediaRankingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotMediaRanking&&const DeepCollectionEquality().equals(other._female, _female)&&const DeepCollectionEquality().equals(other._male, _male)&&const DeepCollectionEquality().equals(other._alien, _alien));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_female),const DeepCollectionEquality().hash(_male),const DeepCollectionEquality().hash(_alien));

@override
String toString() {
  return 'SpotMediaRanking(female: $female, male: $male, alien: $alien)';
}


}

/// @nodoc
abstract mixin class _$SpotMediaRankingCopyWith<$Res> implements $SpotMediaRankingCopyWith<$Res> {
  factory _$SpotMediaRankingCopyWith(_SpotMediaRanking value, $Res Function(_SpotMediaRanking) _then) = __$SpotMediaRankingCopyWithImpl;
@override @useResult
$Res call({
 List<RankedMediaItem> female, List<RankedMediaItem> male, List<RankedMediaItem> alien
});




}
/// @nodoc
class __$SpotMediaRankingCopyWithImpl<$Res>
    implements _$SpotMediaRankingCopyWith<$Res> {
  __$SpotMediaRankingCopyWithImpl(this._self, this._then);

  final _SpotMediaRanking _self;
  final $Res Function(_SpotMediaRanking) _then;

/// Create a copy of SpotMediaRanking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? female = null,Object? male = null,Object? alien = null,}) {
  return _then(_SpotMediaRanking(
female: null == female ? _self._female : female // ignore: cast_nullable_to_non_nullable
as List<RankedMediaItem>,male: null == male ? _self._male : male // ignore: cast_nullable_to_non_nullable
as List<RankedMediaItem>,alien: null == alien ? _self._alien : alien // ignore: cast_nullable_to_non_nullable
as List<RankedMediaItem>,
  ));
}


}

// dart format on
