// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthController on AuthControllerBase, Store {
  late final _$busyAtom =
      Atom(name: 'AuthControllerBase.busy', context: context);

  @override
  bool get busy {
    _$busyAtom.reportRead();
    return super.busy;
  }

  @override
  set busy(bool value) {
    _$busyAtom.reportWrite(value, super.busy, () {
      super.busy = value;
    });
  }

  late final _$typeBetesAtom =
      Atom(name: 'AuthControllerBase.typeBetes', context: context);

  @override
  TypeBetes get typeBetes {
    _$typeBetesAtom.reportRead();
    return super.typeBetes;
  }

  @override
  set typeBetes(TypeBetes value) {
    _$typeBetesAtom.reportWrite(value, super.typeBetes, () {
      super.typeBetes = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('AuthControllerBase.register', context: context);

  @override
  Future<bool> register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  late final _$loginAsyncAction =
      AsyncAction('AuthControllerBase.login', context: context);

  @override
  Future<bool> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$AuthControllerBaseActionController =
      ActionController(name: 'AuthControllerBase', context: context);

  @override
  dynamic changedTypeBetes(TypeBetes? value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.changedTypeBetes');
    try {
      return super.changedTypeBetes(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic goBack() {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.goBack');
    try {
      return super.goBack();
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
busy: ${busy},
typeBetes: ${typeBetes}
    ''';
  }
}
