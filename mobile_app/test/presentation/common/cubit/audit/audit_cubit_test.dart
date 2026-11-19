import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/enums/lock_reason.dart';
import 'package:keeperpass/core/usecases/items/delete_items.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';

import '../../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;

  setUp(() async {
    world = VaultWorld();
    await world.open();
  });

  tearDown(() => world.close());

  test('after unlocking: findings and the badge count', () {
    expect(
      world.audit.state.hasFinding('netflix', AuditType.weakPassword),
      isTrue,
    );
    expect(
      world.audit.state.hasFinding('facebook', AuditType.compromisedPassword),
      isTrue,
    );
    expect(
      world.audit.state.hasFinding('github', AuditType.weakPassword),
      isFalse,
    );
    // Netflix, Instagram and Facebook.
    expect(world.audit.state.flaggedCount, 3);
  });

  test('a deleted item stops counting at once', () async {
    await DeleteItems(world.vault, world.recent)(<String>['netflix']);
    await Future<void>.delayed(Duration.zero);
    expect(world.audit.state.flaggedCount, 2);
  });

  test('locking drops every finding', () async {
    world.session.lock(LockReason.manual);
    await Future<void>.delayed(Duration.zero);
    expect(world.audit.state.findings, isEmpty);
    expect(world.audit.state.flaggedCount, 0);
  });

  test(
    'a run that cannot reach the breach list keeps the last findings',
    () async {
      world.breachesOffline();
      await world.audit.runFullAudit();
      expect(world.audit.state.flaggedCount, 3);
    },
  );

  test('one item re-audited, the rest kept', () async {
    final int lookups = world.breaches.lookups;
    await world.audit.runAuditForItem('github');
    expect(world.breaches.lookups, greaterThan(lookups));
    expect(world.audit.state.findings.keys, hasLength(11));
    expect(world.audit.state.flaggedCount, 3);
  });

  test('a run says when it went through; a failed one says why and keeps '
      'the time and findings of the last', () async {
    expect(world.audit.state.checkedAt, world.now);
    expect(world.audit.state.failure, isNull);
    expect(world.audit.state.checking, isFalse);

    world.breachesOffline();
    expect(await world.audit.runFullAudit(), isFalse);
    expect(world.audit.state.failure, isNotNull);
    expect(world.audit.state.checkedAt, world.now);
    expect(world.audit.state.hasResults, isTrue);

    world.breaches.failure = null;
    expect(await world.audit.runAuditForItem('netflix'), isTrue);
    expect(world.audit.state.failure, isNull);
  });

  test('while a run goes: checking, and how far the lookups are', () async {
    world.breaches.gate = Completer<void>();
    final Future<bool> run = world.audit.runFullAudit();
    await Future<void>.delayed(Duration.zero);
    expect(world.audit.state.checking, isTrue);
    // Nine distinct passwords: ten fields, Instagram and Facebook share one.
    expect(world.audit.state.toLookUp, 9);
    expect(world.audit.state.lookedUp, 0);
    expect(world.audit.state.timeLeft, isNull);

    world.breaches.gate!.complete();
    expect(await run, isTrue);
    expect(world.audit.state.checking, isFalse);
    expect(world.audit.state.lookedUp, 9);
  });

  test('a run that started before a lock never lands after it', () async {
    world.breaches.gate = Completer<void>();
    final Future<bool> run = world.audit.runFullAudit();
    await Future<void>.delayed(Duration.zero);
    world.session.lock(LockReason.manual);
    await Future<void>.delayed(Duration.zero);
    world.breaches.gate!.complete();
    expect(await run, isFalse);
    expect(world.audit.state, const AuditState());
  });
}
