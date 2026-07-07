// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hazzard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Hazzard {

 int get id;@JsonKey(name: 'spot_id') int get spotId; String get name; String? get description; int? get severity;@JsonKey(name: 'created_date') DateTime get createdDate;
/// Create a copy of Hazzard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HazzardCopyWith<Hazzard> get copyWith => _$HazzardCopyWithImpl<Hazzard>(this as Hazzard, _$identity);

  /// Serializes this Hazzard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hazzard&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,name,description,severity,createdDate);

@override
String toString() {
  return 'Hazzard(id: $id, spotId: $spotId, name: $name, description: $description, severity: $severity, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $HazzardCopyWith<$Res>  {
  factory $HazzardCopyWith(Hazzard value, $Res Function(Hazzard) _then) = _$HazzardCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId, String name, String? description, int? severity,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class _$HazzardCopyWithImpl<$Res>
    implements $HazzardCopyWith<$Res> {
  _$HazzardCopyWithImpl(this._self, this._then);

  final Hazzard _self;
  final $Res Function(Hazzard) _then;

/// Create a copy of Hazzard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? spotId = null,Object? name = null,Object? description = freezed,Object? severity = freezed,Object? createdDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as int?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Hazzard].
extension HazzardPatterns on Hazzard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hazzard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hazzard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hazzard value)  $default,){
final _that = this;
switch (_that) {
case _Hazzard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hazzard value)?  $default,){
final _that = this;
switch (_that) {
case _Hazzard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId,  String name,  String? description,  int? severity, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hazzard() when $default != null:
return $default(_that.id,_that.spotId,_that.name,_that.description,_that.severity,_that.createdDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId,  String name,  String? description,  int? severity, @JsonKey(name: 'created_date')  DateTime createdDate)  $default,) {final _that = this;
switch (_that) {
case _Hazzard():
return $default(_that.id,_that.spotId,_that.name,_that.description,_that.severity,_that.createdDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'spot_id')  int spotId,  String name,  String? description,  int? severity, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,) {final _that = this;
switch (_that) {
case _Hazzard() when $default != null:
return $default(_that.id,_that.spotId,_that.name,_that.description,_that.severity,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hazzard implements Hazzard {
  const _Hazzard({required this.id, @JsonKey(name: 'spot_id') required this.spotId, required this.name, this.description, this.severity, @JsonKey(name: 'created_date') required this.createdDate});
  factory _Hazzard.fromJson(Map<String, dynamic> json) => _$HazzardFromJson(json);

@override final  int id;
@override@JsonKey(name: 'spot_id') final  int spotId;
@override final  String name;
@override final  String? description;
@override final  int? severity;
@override@JsonKey(name: 'created_date') final  DateTime createdDate;

/// Create a copy of Hazzard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HazzardCopyWith<_Hazzard> get copyWith => __$HazzardCopyWithImpl<_Hazzard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HazzardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hazzard&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,name,description,severity,createdDate);

@override
String toString() {
  return 'Hazzard(id: $id, spotId: $spotId, name: $name, description: $description, severity: $severity, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$HazzardCopyWith<$Res> implements $HazzardCopyWith<$Res> {
  factory _$HazzardCopyWith(_Hazzard value, $Res Function(_Hazzard) _then) = __$HazzardCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId, String name, String? description, int? severity,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class __$HazzardCopyWithImpl<$Res>
    implements _$HazzardCopyWith<$Res> {
  __$HazzardCopyWithImpl(this._self, this._then);

  final _Hazzard _self;
  final $Res Function(_Hazzard) _then;

/// Create a copy of Hazzard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? spotId = null,Object? name = null,Object? description = freezed,Object? severity = freezed,Object? createdDate = null,}) {
  return _then(_Hazzard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as int?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
