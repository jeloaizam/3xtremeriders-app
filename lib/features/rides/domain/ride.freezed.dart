// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Ride {

 int get id; String get name;@JsonKey(name: 'owner_id') int get ownerId;@JsonKey(name: 'state_id') int? get stateId; int? get condition;@JsonKey(name: 'cover_photo_id') int? get coverPhotoId;@JsonKey(name: 'cover_photo_url') String? get coverPhotoUrl;@JsonKey(name: 'created_date') DateTime get createdDate;@JsonKey(name: 'wasted_date') DateTime? get wastedDate;
/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideCopyWith<Ride> get copyWith => _$RideCopyWithImpl<Ride>(this as Ride, _$identity);

  /// Serializes this Ride to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ride&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.stateId, stateId) || other.stateId == stateId)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.coverPhotoId, coverPhotoId) || other.coverPhotoId == coverPhotoId)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.wastedDate, wastedDate) || other.wastedDate == wastedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,ownerId,stateId,condition,coverPhotoId,coverPhotoUrl,createdDate,wastedDate);

@override
String toString() {
  return 'Ride(id: $id, name: $name, ownerId: $ownerId, stateId: $stateId, condition: $condition, coverPhotoId: $coverPhotoId, coverPhotoUrl: $coverPhotoUrl, createdDate: $createdDate, wastedDate: $wastedDate)';
}


}

/// @nodoc
abstract mixin class $RideCopyWith<$Res>  {
  factory $RideCopyWith(Ride value, $Res Function(Ride) _then) = _$RideCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'owner_id') int ownerId,@JsonKey(name: 'state_id') int? stateId, int? condition,@JsonKey(name: 'cover_photo_id') int? coverPhotoId,@JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,@JsonKey(name: 'created_date') DateTime createdDate,@JsonKey(name: 'wasted_date') DateTime? wastedDate
});




}
/// @nodoc
class _$RideCopyWithImpl<$Res>
    implements $RideCopyWith<$Res> {
  _$RideCopyWithImpl(this._self, this._then);

  final Ride _self;
  final $Res Function(Ride) _then;

/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? ownerId = null,Object? stateId = freezed,Object? condition = freezed,Object? coverPhotoId = freezed,Object? coverPhotoUrl = freezed,Object? createdDate = null,Object? wastedDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,stateId: freezed == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as int?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as int?,coverPhotoId: freezed == coverPhotoId ? _self.coverPhotoId : coverPhotoId // ignore: cast_nullable_to_non_nullable
as int?,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,wastedDate: freezed == wastedDate ? _self.wastedDate : wastedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Ride].
extension RidePatterns on Ride {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ride value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ride() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ride value)  $default,){
final _that = this;
switch (_that) {
case _Ride():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ride value)?  $default,){
final _that = this;
switch (_that) {
case _Ride() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'owner_id')  int ownerId, @JsonKey(name: 'state_id')  int? stateId,  int? condition, @JsonKey(name: 'cover_photo_id')  int? coverPhotoId, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'created_date')  DateTime createdDate, @JsonKey(name: 'wasted_date')  DateTime? wastedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ride() when $default != null:
return $default(_that.id,_that.name,_that.ownerId,_that.stateId,_that.condition,_that.coverPhotoId,_that.coverPhotoUrl,_that.createdDate,_that.wastedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'owner_id')  int ownerId, @JsonKey(name: 'state_id')  int? stateId,  int? condition, @JsonKey(name: 'cover_photo_id')  int? coverPhotoId, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'created_date')  DateTime createdDate, @JsonKey(name: 'wasted_date')  DateTime? wastedDate)  $default,) {final _that = this;
switch (_that) {
case _Ride():
return $default(_that.id,_that.name,_that.ownerId,_that.stateId,_that.condition,_that.coverPhotoId,_that.coverPhotoUrl,_that.createdDate,_that.wastedDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'owner_id')  int ownerId, @JsonKey(name: 'state_id')  int? stateId,  int? condition, @JsonKey(name: 'cover_photo_id')  int? coverPhotoId, @JsonKey(name: 'cover_photo_url')  String? coverPhotoUrl, @JsonKey(name: 'created_date')  DateTime createdDate, @JsonKey(name: 'wasted_date')  DateTime? wastedDate)?  $default,) {final _that = this;
switch (_that) {
case _Ride() when $default != null:
return $default(_that.id,_that.name,_that.ownerId,_that.stateId,_that.condition,_that.coverPhotoId,_that.coverPhotoUrl,_that.createdDate,_that.wastedDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ride implements Ride {
  const _Ride({required this.id, required this.name, @JsonKey(name: 'owner_id') required this.ownerId, @JsonKey(name: 'state_id') this.stateId, this.condition, @JsonKey(name: 'cover_photo_id') this.coverPhotoId, @JsonKey(name: 'cover_photo_url') this.coverPhotoUrl, @JsonKey(name: 'created_date') required this.createdDate, @JsonKey(name: 'wasted_date') this.wastedDate});
  factory _Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'owner_id') final  int ownerId;
@override@JsonKey(name: 'state_id') final  int? stateId;
@override final  int? condition;
@override@JsonKey(name: 'cover_photo_id') final  int? coverPhotoId;
@override@JsonKey(name: 'cover_photo_url') final  String? coverPhotoUrl;
@override@JsonKey(name: 'created_date') final  DateTime createdDate;
@override@JsonKey(name: 'wasted_date') final  DateTime? wastedDate;

/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RideCopyWith<_Ride> get copyWith => __$RideCopyWithImpl<_Ride>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ride&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.stateId, stateId) || other.stateId == stateId)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.coverPhotoId, coverPhotoId) || other.coverPhotoId == coverPhotoId)&&(identical(other.coverPhotoUrl, coverPhotoUrl) || other.coverPhotoUrl == coverPhotoUrl)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.wastedDate, wastedDate) || other.wastedDate == wastedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,ownerId,stateId,condition,coverPhotoId,coverPhotoUrl,createdDate,wastedDate);

@override
String toString() {
  return 'Ride(id: $id, name: $name, ownerId: $ownerId, stateId: $stateId, condition: $condition, coverPhotoId: $coverPhotoId, coverPhotoUrl: $coverPhotoUrl, createdDate: $createdDate, wastedDate: $wastedDate)';
}


}

/// @nodoc
abstract mixin class _$RideCopyWith<$Res> implements $RideCopyWith<$Res> {
  factory _$RideCopyWith(_Ride value, $Res Function(_Ride) _then) = __$RideCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'owner_id') int ownerId,@JsonKey(name: 'state_id') int? stateId, int? condition,@JsonKey(name: 'cover_photo_id') int? coverPhotoId,@JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,@JsonKey(name: 'created_date') DateTime createdDate,@JsonKey(name: 'wasted_date') DateTime? wastedDate
});




}
/// @nodoc
class __$RideCopyWithImpl<$Res>
    implements _$RideCopyWith<$Res> {
  __$RideCopyWithImpl(this._self, this._then);

  final _Ride _self;
  final $Res Function(_Ride) _then;

/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? ownerId = null,Object? stateId = freezed,Object? condition = freezed,Object? coverPhotoId = freezed,Object? coverPhotoUrl = freezed,Object? createdDate = null,Object? wastedDate = freezed,}) {
  return _then(_Ride(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as int,stateId: freezed == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as int?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as int?,coverPhotoId: freezed == coverPhotoId ? _self.coverPhotoId : coverPhotoId // ignore: cast_nullable_to_non_nullable
as int?,coverPhotoUrl: freezed == coverPhotoUrl ? _self.coverPhotoUrl : coverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,wastedDate: freezed == wastedDate ? _self.wastedDate : wastedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
