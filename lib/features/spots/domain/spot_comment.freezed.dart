// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotComment {

 int get id;@JsonKey(name: 'rider_id') int get riderId;@JsonKey(name: 'parent_id') int? get parentId; String get body;@JsonKey(name: 'vote_count') int get voteCount;@JsonKey(name: 'created_date') DateTime get createdDate;
/// Create a copy of SpotComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotCommentCopyWith<SpotComment> get copyWith => _$SpotCommentCopyWithImpl<SpotComment>(this as SpotComment, _$identity);

  /// Serializes this SpotComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotComment&&(identical(other.id, id) || other.id == id)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.body, body) || other.body == body)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,riderId,parentId,body,voteCount,createdDate);

@override
String toString() {
  return 'SpotComment(id: $id, riderId: $riderId, parentId: $parentId, body: $body, voteCount: $voteCount, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $SpotCommentCopyWith<$Res>  {
  factory $SpotCommentCopyWith(SpotComment value, $Res Function(SpotComment) _then) = _$SpotCommentCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'rider_id') int riderId,@JsonKey(name: 'parent_id') int? parentId, String body,@JsonKey(name: 'vote_count') int voteCount,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class _$SpotCommentCopyWithImpl<$Res>
    implements $SpotCommentCopyWith<$Res> {
  _$SpotCommentCopyWithImpl(this._self, this._then);

  final SpotComment _self;
  final $Res Function(SpotComment) _then;

/// Create a copy of SpotComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? riderId = null,Object? parentId = freezed,Object? body = null,Object? voteCount = null,Object? createdDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotComment].
extension SpotCommentPatterns on SpotComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotComment value)  $default,){
final _that = this;
switch (_that) {
case _SpotComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotComment value)?  $default,){
final _that = this;
switch (_that) {
case _SpotComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'parent_id')  int? parentId,  String body, @JsonKey(name: 'vote_count')  int voteCount, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotComment() when $default != null:
return $default(_that.id,_that.riderId,_that.parentId,_that.body,_that.voteCount,_that.createdDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'parent_id')  int? parentId,  String body, @JsonKey(name: 'vote_count')  int voteCount, @JsonKey(name: 'created_date')  DateTime createdDate)  $default,) {final _that = this;
switch (_that) {
case _SpotComment():
return $default(_that.id,_that.riderId,_that.parentId,_that.body,_that.voteCount,_that.createdDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'parent_id')  int? parentId,  String body, @JsonKey(name: 'vote_count')  int voteCount, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,) {final _that = this;
switch (_that) {
case _SpotComment() when $default != null:
return $default(_that.id,_that.riderId,_that.parentId,_that.body,_that.voteCount,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotComment implements SpotComment {
  const _SpotComment({required this.id, @JsonKey(name: 'rider_id') required this.riderId, @JsonKey(name: 'parent_id') this.parentId, required this.body, @JsonKey(name: 'vote_count') required this.voteCount, @JsonKey(name: 'created_date') required this.createdDate});
  factory _SpotComment.fromJson(Map<String, dynamic> json) => _$SpotCommentFromJson(json);

@override final  int id;
@override@JsonKey(name: 'rider_id') final  int riderId;
@override@JsonKey(name: 'parent_id') final  int? parentId;
@override final  String body;
@override@JsonKey(name: 'vote_count') final  int voteCount;
@override@JsonKey(name: 'created_date') final  DateTime createdDate;

/// Create a copy of SpotComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotCommentCopyWith<_SpotComment> get copyWith => __$SpotCommentCopyWithImpl<_SpotComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotCommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotComment&&(identical(other.id, id) || other.id == id)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.body, body) || other.body == body)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,riderId,parentId,body,voteCount,createdDate);

@override
String toString() {
  return 'SpotComment(id: $id, riderId: $riderId, parentId: $parentId, body: $body, voteCount: $voteCount, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$SpotCommentCopyWith<$Res> implements $SpotCommentCopyWith<$Res> {
  factory _$SpotCommentCopyWith(_SpotComment value, $Res Function(_SpotComment) _then) = __$SpotCommentCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'rider_id') int riderId,@JsonKey(name: 'parent_id') int? parentId, String body,@JsonKey(name: 'vote_count') int voteCount,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class __$SpotCommentCopyWithImpl<$Res>
    implements _$SpotCommentCopyWith<$Res> {
  __$SpotCommentCopyWithImpl(this._self, this._then);

  final _SpotComment _self;
  final $Res Function(_SpotComment) _then;

/// Create a copy of SpotComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? riderId = null,Object? parentId = freezed,Object? body = null,Object? voteCount = null,Object? createdDate = null,}) {
  return _then(_SpotComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
