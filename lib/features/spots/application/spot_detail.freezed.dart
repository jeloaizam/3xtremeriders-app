// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpotCommentWithAuthor {

 SpotComment get comment; Rider get author;
/// Create a copy of SpotCommentWithAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotCommentWithAuthorCopyWith<SpotCommentWithAuthor> get copyWith => _$SpotCommentWithAuthorCopyWithImpl<SpotCommentWithAuthor>(this as SpotCommentWithAuthor, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotCommentWithAuthor&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.author, author) || other.author == author));
}


@override
int get hashCode => Object.hash(runtimeType,comment,author);

@override
String toString() {
  return 'SpotCommentWithAuthor(comment: $comment, author: $author)';
}


}

/// @nodoc
abstract mixin class $SpotCommentWithAuthorCopyWith<$Res>  {
  factory $SpotCommentWithAuthorCopyWith(SpotCommentWithAuthor value, $Res Function(SpotCommentWithAuthor) _then) = _$SpotCommentWithAuthorCopyWithImpl;
@useResult
$Res call({
 SpotComment comment, Rider author
});


$SpotCommentCopyWith<$Res> get comment;$RiderCopyWith<$Res> get author;

}
/// @nodoc
class _$SpotCommentWithAuthorCopyWithImpl<$Res>
    implements $SpotCommentWithAuthorCopyWith<$Res> {
  _$SpotCommentWithAuthorCopyWithImpl(this._self, this._then);

  final SpotCommentWithAuthor _self;
  final $Res Function(SpotCommentWithAuthor) _then;

/// Create a copy of SpotCommentWithAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? comment = null,Object? author = null,}) {
  return _then(_self.copyWith(
comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as SpotComment,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Rider,
  ));
}
/// Create a copy of SpotCommentWithAuthor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpotCommentCopyWith<$Res> get comment {
  
  return $SpotCommentCopyWith<$Res>(_self.comment, (value) {
    return _then(_self.copyWith(comment: value));
  });
}/// Create a copy of SpotCommentWithAuthor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RiderCopyWith<$Res> get author {
  
  return $RiderCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [SpotCommentWithAuthor].
extension SpotCommentWithAuthorPatterns on SpotCommentWithAuthor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotCommentWithAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotCommentWithAuthor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotCommentWithAuthor value)  $default,){
final _that = this;
switch (_that) {
case _SpotCommentWithAuthor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotCommentWithAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _SpotCommentWithAuthor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SpotComment comment,  Rider author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotCommentWithAuthor() when $default != null:
return $default(_that.comment,_that.author);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SpotComment comment,  Rider author)  $default,) {final _that = this;
switch (_that) {
case _SpotCommentWithAuthor():
return $default(_that.comment,_that.author);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SpotComment comment,  Rider author)?  $default,) {final _that = this;
switch (_that) {
case _SpotCommentWithAuthor() when $default != null:
return $default(_that.comment,_that.author);case _:
  return null;

}
}

}

/// @nodoc


class _SpotCommentWithAuthor implements SpotCommentWithAuthor {
  const _SpotCommentWithAuthor({required this.comment, required this.author});
  

@override final  SpotComment comment;
@override final  Rider author;

/// Create a copy of SpotCommentWithAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotCommentWithAuthorCopyWith<_SpotCommentWithAuthor> get copyWith => __$SpotCommentWithAuthorCopyWithImpl<_SpotCommentWithAuthor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotCommentWithAuthor&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.author, author) || other.author == author));
}


@override
int get hashCode => Object.hash(runtimeType,comment,author);

@override
String toString() {
  return 'SpotCommentWithAuthor(comment: $comment, author: $author)';
}


}

/// @nodoc
abstract mixin class _$SpotCommentWithAuthorCopyWith<$Res> implements $SpotCommentWithAuthorCopyWith<$Res> {
  factory _$SpotCommentWithAuthorCopyWith(_SpotCommentWithAuthor value, $Res Function(_SpotCommentWithAuthor) _then) = __$SpotCommentWithAuthorCopyWithImpl;
@override @useResult
$Res call({
 SpotComment comment, Rider author
});


@override $SpotCommentCopyWith<$Res> get comment;@override $RiderCopyWith<$Res> get author;

}
/// @nodoc
class __$SpotCommentWithAuthorCopyWithImpl<$Res>
    implements _$SpotCommentWithAuthorCopyWith<$Res> {
  __$SpotCommentWithAuthorCopyWithImpl(this._self, this._then);

  final _SpotCommentWithAuthor _self;
  final $Res Function(_SpotCommentWithAuthor) _then;

/// Create a copy of SpotCommentWithAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? comment = null,Object? author = null,}) {
  return _then(_SpotCommentWithAuthor(
comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as SpotComment,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Rider,
  ));
}

/// Create a copy of SpotCommentWithAuthor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpotCommentCopyWith<$Res> get comment {
  
  return $SpotCommentCopyWith<$Res>(_self.comment, (value) {
    return _then(_self.copyWith(comment: value));
  });
}/// Create a copy of SpotCommentWithAuthor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RiderCopyWith<$Res> get author {
  
  return $RiderCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

/// @nodoc
mixin _$SpotDetailData {

 Spot get spot; List<Sport> get sports; List<SpotElement> get elements; List<Hazzard> get hazzards; List<SpotCommentWithAuthor> get comments; Rider get creator; bool get iLiked; SpotRating? get myRating; SpotHazardRating? get myHazardRating;
/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotDetailDataCopyWith<SpotDetailData> get copyWith => _$SpotDetailDataCopyWithImpl<SpotDetailData>(this as SpotDetailData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotDetailData&&(identical(other.spot, spot) || other.spot == spot)&&const DeepCollectionEquality().equals(other.sports, sports)&&const DeepCollectionEquality().equals(other.elements, elements)&&const DeepCollectionEquality().equals(other.hazzards, hazzards)&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.iLiked, iLiked) || other.iLiked == iLiked)&&(identical(other.myRating, myRating) || other.myRating == myRating)&&(identical(other.myHazardRating, myHazardRating) || other.myHazardRating == myHazardRating));
}


@override
int get hashCode => Object.hash(runtimeType,spot,const DeepCollectionEquality().hash(sports),const DeepCollectionEquality().hash(elements),const DeepCollectionEquality().hash(hazzards),const DeepCollectionEquality().hash(comments),creator,iLiked,myRating,myHazardRating);

@override
String toString() {
  return 'SpotDetailData(spot: $spot, sports: $sports, elements: $elements, hazzards: $hazzards, comments: $comments, creator: $creator, iLiked: $iLiked, myRating: $myRating, myHazardRating: $myHazardRating)';
}


}

/// @nodoc
abstract mixin class $SpotDetailDataCopyWith<$Res>  {
  factory $SpotDetailDataCopyWith(SpotDetailData value, $Res Function(SpotDetailData) _then) = _$SpotDetailDataCopyWithImpl;
@useResult
$Res call({
 Spot spot, List<Sport> sports, List<SpotElement> elements, List<Hazzard> hazzards, List<SpotCommentWithAuthor> comments, Rider creator, bool iLiked, SpotRating? myRating, SpotHazardRating? myHazardRating
});


$SpotCopyWith<$Res> get spot;$RiderCopyWith<$Res> get creator;$SpotRatingCopyWith<$Res>? get myRating;$SpotHazardRatingCopyWith<$Res>? get myHazardRating;

}
/// @nodoc
class _$SpotDetailDataCopyWithImpl<$Res>
    implements $SpotDetailDataCopyWith<$Res> {
  _$SpotDetailDataCopyWithImpl(this._self, this._then);

  final SpotDetailData _self;
  final $Res Function(SpotDetailData) _then;

/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? spot = null,Object? sports = null,Object? elements = null,Object? hazzards = null,Object? comments = null,Object? creator = null,Object? iLiked = null,Object? myRating = freezed,Object? myHazardRating = freezed,}) {
  return _then(_self.copyWith(
spot: null == spot ? _self.spot : spot // ignore: cast_nullable_to_non_nullable
as Spot,sports: null == sports ? _self.sports : sports // ignore: cast_nullable_to_non_nullable
as List<Sport>,elements: null == elements ? _self.elements : elements // ignore: cast_nullable_to_non_nullable
as List<SpotElement>,hazzards: null == hazzards ? _self.hazzards : hazzards // ignore: cast_nullable_to_non_nullable
as List<Hazzard>,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<SpotCommentWithAuthor>,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as Rider,iLiked: null == iLiked ? _self.iLiked : iLiked // ignore: cast_nullable_to_non_nullable
as bool,myRating: freezed == myRating ? _self.myRating : myRating // ignore: cast_nullable_to_non_nullable
as SpotRating?,myHazardRating: freezed == myHazardRating ? _self.myHazardRating : myHazardRating // ignore: cast_nullable_to_non_nullable
as SpotHazardRating?,
  ));
}
/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpotCopyWith<$Res> get spot {
  
  return $SpotCopyWith<$Res>(_self.spot, (value) {
    return _then(_self.copyWith(spot: value));
  });
}/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RiderCopyWith<$Res> get creator {
  
  return $RiderCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpotRatingCopyWith<$Res>? get myRating {
    if (_self.myRating == null) {
    return null;
  }

  return $SpotRatingCopyWith<$Res>(_self.myRating!, (value) {
    return _then(_self.copyWith(myRating: value));
  });
}/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpotHazardRatingCopyWith<$Res>? get myHazardRating {
    if (_self.myHazardRating == null) {
    return null;
  }

  return $SpotHazardRatingCopyWith<$Res>(_self.myHazardRating!, (value) {
    return _then(_self.copyWith(myHazardRating: value));
  });
}
}


/// Adds pattern-matching-related methods to [SpotDetailData].
extension SpotDetailDataPatterns on SpotDetailData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotDetailData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotDetailData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotDetailData value)  $default,){
final _that = this;
switch (_that) {
case _SpotDetailData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotDetailData value)?  $default,){
final _that = this;
switch (_that) {
case _SpotDetailData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Spot spot,  List<Sport> sports,  List<SpotElement> elements,  List<Hazzard> hazzards,  List<SpotCommentWithAuthor> comments,  Rider creator,  bool iLiked,  SpotRating? myRating,  SpotHazardRating? myHazardRating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotDetailData() when $default != null:
return $default(_that.spot,_that.sports,_that.elements,_that.hazzards,_that.comments,_that.creator,_that.iLiked,_that.myRating,_that.myHazardRating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Spot spot,  List<Sport> sports,  List<SpotElement> elements,  List<Hazzard> hazzards,  List<SpotCommentWithAuthor> comments,  Rider creator,  bool iLiked,  SpotRating? myRating,  SpotHazardRating? myHazardRating)  $default,) {final _that = this;
switch (_that) {
case _SpotDetailData():
return $default(_that.spot,_that.sports,_that.elements,_that.hazzards,_that.comments,_that.creator,_that.iLiked,_that.myRating,_that.myHazardRating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Spot spot,  List<Sport> sports,  List<SpotElement> elements,  List<Hazzard> hazzards,  List<SpotCommentWithAuthor> comments,  Rider creator,  bool iLiked,  SpotRating? myRating,  SpotHazardRating? myHazardRating)?  $default,) {final _that = this;
switch (_that) {
case _SpotDetailData() when $default != null:
return $default(_that.spot,_that.sports,_that.elements,_that.hazzards,_that.comments,_that.creator,_that.iLiked,_that.myRating,_that.myHazardRating);case _:
  return null;

}
}

}

/// @nodoc


class _SpotDetailData implements SpotDetailData {
  const _SpotDetailData({required this.spot, required final  List<Sport> sports, required final  List<SpotElement> elements, required final  List<Hazzard> hazzards, required final  List<SpotCommentWithAuthor> comments, required this.creator, required this.iLiked, this.myRating, this.myHazardRating}): _sports = sports,_elements = elements,_hazzards = hazzards,_comments = comments;
  

@override final  Spot spot;
 final  List<Sport> _sports;
@override List<Sport> get sports {
  if (_sports is EqualUnmodifiableListView) return _sports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sports);
}

 final  List<SpotElement> _elements;
@override List<SpotElement> get elements {
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elements);
}

 final  List<Hazzard> _hazzards;
@override List<Hazzard> get hazzards {
  if (_hazzards is EqualUnmodifiableListView) return _hazzards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hazzards);
}

 final  List<SpotCommentWithAuthor> _comments;
@override List<SpotCommentWithAuthor> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override final  Rider creator;
@override final  bool iLiked;
@override final  SpotRating? myRating;
@override final  SpotHazardRating? myHazardRating;

/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotDetailDataCopyWith<_SpotDetailData> get copyWith => __$SpotDetailDataCopyWithImpl<_SpotDetailData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotDetailData&&(identical(other.spot, spot) || other.spot == spot)&&const DeepCollectionEquality().equals(other._sports, _sports)&&const DeepCollectionEquality().equals(other._elements, _elements)&&const DeepCollectionEquality().equals(other._hazzards, _hazzards)&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.iLiked, iLiked) || other.iLiked == iLiked)&&(identical(other.myRating, myRating) || other.myRating == myRating)&&(identical(other.myHazardRating, myHazardRating) || other.myHazardRating == myHazardRating));
}


@override
int get hashCode => Object.hash(runtimeType,spot,const DeepCollectionEquality().hash(_sports),const DeepCollectionEquality().hash(_elements),const DeepCollectionEquality().hash(_hazzards),const DeepCollectionEquality().hash(_comments),creator,iLiked,myRating,myHazardRating);

@override
String toString() {
  return 'SpotDetailData(spot: $spot, sports: $sports, elements: $elements, hazzards: $hazzards, comments: $comments, creator: $creator, iLiked: $iLiked, myRating: $myRating, myHazardRating: $myHazardRating)';
}


}

/// @nodoc
abstract mixin class _$SpotDetailDataCopyWith<$Res> implements $SpotDetailDataCopyWith<$Res> {
  factory _$SpotDetailDataCopyWith(_SpotDetailData value, $Res Function(_SpotDetailData) _then) = __$SpotDetailDataCopyWithImpl;
@override @useResult
$Res call({
 Spot spot, List<Sport> sports, List<SpotElement> elements, List<Hazzard> hazzards, List<SpotCommentWithAuthor> comments, Rider creator, bool iLiked, SpotRating? myRating, SpotHazardRating? myHazardRating
});


@override $SpotCopyWith<$Res> get spot;@override $RiderCopyWith<$Res> get creator;@override $SpotRatingCopyWith<$Res>? get myRating;@override $SpotHazardRatingCopyWith<$Res>? get myHazardRating;

}
/// @nodoc
class __$SpotDetailDataCopyWithImpl<$Res>
    implements _$SpotDetailDataCopyWith<$Res> {
  __$SpotDetailDataCopyWithImpl(this._self, this._then);

  final _SpotDetailData _self;
  final $Res Function(_SpotDetailData) _then;

/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? spot = null,Object? sports = null,Object? elements = null,Object? hazzards = null,Object? comments = null,Object? creator = null,Object? iLiked = null,Object? myRating = freezed,Object? myHazardRating = freezed,}) {
  return _then(_SpotDetailData(
spot: null == spot ? _self.spot : spot // ignore: cast_nullable_to_non_nullable
as Spot,sports: null == sports ? _self._sports : sports // ignore: cast_nullable_to_non_nullable
as List<Sport>,elements: null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<SpotElement>,hazzards: null == hazzards ? _self._hazzards : hazzards // ignore: cast_nullable_to_non_nullable
as List<Hazzard>,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<SpotCommentWithAuthor>,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as Rider,iLiked: null == iLiked ? _self.iLiked : iLiked // ignore: cast_nullable_to_non_nullable
as bool,myRating: freezed == myRating ? _self.myRating : myRating // ignore: cast_nullable_to_non_nullable
as SpotRating?,myHazardRating: freezed == myHazardRating ? _self.myHazardRating : myHazardRating // ignore: cast_nullable_to_non_nullable
as SpotHazardRating?,
  ));
}

/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpotCopyWith<$Res> get spot {
  
  return $SpotCopyWith<$Res>(_self.spot, (value) {
    return _then(_self.copyWith(spot: value));
  });
}/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RiderCopyWith<$Res> get creator {
  
  return $RiderCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpotRatingCopyWith<$Res>? get myRating {
    if (_self.myRating == null) {
    return null;
  }

  return $SpotRatingCopyWith<$Res>(_self.myRating!, (value) {
    return _then(_self.copyWith(myRating: value));
  });
}/// Create a copy of SpotDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpotHazardRatingCopyWith<$Res>? get myHazardRating {
    if (_self.myHazardRating == null) {
    return null;
  }

  return $SpotHazardRatingCopyWith<$Res>(_self.myHazardRating!, (value) {
    return _then(_self.copyWith(myHazardRating: value));
  });
}
}

// dart format on
