import '../models/app_user.dart';
import '../models/customer.dart';
import '../models/damage_record.dart';
import '../models/enums.dart';
import '../models/rental_contract.dart';
import '../models/trailer.dart';
import '../repositories/contract_repository.dart';
import '../repositories/customer_repository.dart';
import '../repositories/damage_repository.dart';
import '../repositories/trailer_repository.dart';
import '../repositories/trailer_type_repository.dart';
import '../repositories/user_repository.dart';

class SampleDataSeeder {
  SampleDataSeeder({
    required this.users,
    required this.trailerTypes,
    required this.trailers,
    required this.customers,
    required this.contracts,
    required this.damages,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final UserRepository users;
  final TrailerTypeRepository trailerTypes;
  final TrailerRepository trailers;
  final CustomerRepository customers;
  final ContractRepository contracts;
  final DamageRepository damages;
  final DateTime Function() _now;

  static const List<String> sampleUserNames = <String>[
    'Kalle Kupplung',
    'Paula Plane',
  ];

  Future<bool> isEmpty() async {
    final List<Trailer> existingTrailers = await trailers
        .watchAll(query: const TrailerQuery(includeArchived: true))
        .first;
    final List<Customer> existingCustomers = await customers
        .watchAll(includeArchived: true)
        .first;
    final List<RentalContract> existingContracts = await contracts
        .watchAll()
        .first;
    return existingTrailers.isEmpty &&
        existingCustomers.isEmpty &&
        existingContracts.isEmpty;
  }

  Future<bool> seedIfEmpty() async {
    if (!await isEmpty()) {
      return false;
    }
    await seed();
    return true;
  }

  Future<void> seed() async {
    final DateTime now = _now();
    final int adminId = await _ensureUsers();
    final Map<String, int> typeIds = await _typeIds();

    final List<Trailer> fleet = <Trailer>[];
    for (final _SampleTrailer sample in _sampleTrailers) {
      final Trailer trailer = await trailers.create(
        TrailerDraft(
          internalCode: sample.code,
          licensePlate: sample.plate,
          typeId: typeIds[sample.type] ?? typeIds.values.first,
        ),
        userId: adminId,
      );
      await trailers.updateLocation(
        trailer.id,
        TrailerLocation(
          address: sample.address,
          latitude: sample.latitude,
          longitude: sample.longitude,
        ),
      );
      fleet.add(trailer);
    }

    final List<Customer> people = <Customer>[];
    for (final CustomerDraft draft in _sampleCustomers) {
      people.add(await customers.create(draft));
    }

    await _seedHistory(fleet, people, adminId, now);
    await _seedCurrent(fleet, people, adminId, now);
    await _seedDamages(fleet, people, adminId, now);

    await trailers.changeStatus(
      fleet[1].id,
      TrailerStatus.maintenance,
      userId: adminId,
    );
    await trailers.changeStatus(
      fleet[5].id,
      TrailerStatus.blocked,
      userId: adminId,
    );
  }

  Future<int> _ensureUsers() async {
    final List<AppUser> existing = await users
        .watchAll(includeInactive: true)
        .first;
    for (final String name in sampleUserNames) {
      if (!existing.any((AppUser user) => user.name == name)) {
        await users.create(name);
      }
    }
    final List<AppUser> all = await users.watchAll(includeInactive: true).first;
    return all.first.id;
  }

  Future<Map<String, int>> _typeIds() async {
    final List<TrailerType> types = await trailerTypes.watchAll().first;
    if (types.isEmpty) {
      final TrailerType created = await trailerTypes.create('Pkw-Anhänger');
      return <String, int>{created.name: created.id};
    }
    return <String, int>{
      for (final TrailerType type in types) type.name: type.id,
    };
  }

  Future<void> _seedHistory(
    List<Trailer> fleet,
    List<Customer> people,
    int userId,
    DateTime now,
  ) async {
    final List<int> rentable = <int>[0, 2, 3, 4, 6, 7];
    final DateTime latestEnd = now.subtract(const Duration(days: 2));
    int counter = 0;
    for (int monthsAgo = 11; monthsAgo >= 0; monthsAgo--) {
      final DateTime month = DateTime(now.year, now.month - monthsAgo);
      final int rentalsThisMonth = 2 + (monthsAgo * 5 + 3) % 4;
      for (int i = 0; i < rentalsThisMonth; i++) {
        final int fleetIndex = rentable[(counter + i) % rentable.length];
        final int day = 2 + i * 6;
        final int days = 1 + (counter + i) % 3;
        final DateTime start = DateTime(month.year, month.month, day, 9);
        final DateTime end = start.add(Duration(days: days, hours: 8));
        if (end.isAfter(latestEnd)) {
          continue;
        }
        final Trailer trailer = fleet[fleetIndex];
        final RentalContract contract = await contracts.create(
          RentalContractDraft(
            customerId: people[(counter + i) % people.length].id,
            trailerId: trailer.id,
            startAt: start,
            endAt: end,
            pickupLocation: 'Hof Nord',
            returnLocation: 'Hof Nord',
            priceCents: _priceFor(fleetIndex, days),
          ),
          userId: userId,
        );
        await contracts.handOver(contract.id, userId: userId);
        await contracts.completeReturn(contract.id, userId: userId);
      }
      counter += rentalsThisMonth;
    }
  }

  Future<void> _seedCurrent(
    List<Trailer> fleet,
    List<Customer> people,
    int userId,
    DateTime now,
  ) async {
    final DateTime today = DateTime(now.year, now.month, now.day, 9);

    final RentalContract running = await contracts.create(
      RentalContractDraft(
        customerId: people[0].id,
        trailerId: fleet[0].id,
        startAt: today.subtract(const Duration(days: 1)),
        endAt: today.add(const Duration(days: 2)),
        pickupLocation: 'Hof Nord',
        returnLocation: 'Hof Süd',
        priceCents: 8900,
      ),
      userId: userId,
    );
    await contracts.handOver(running.id, userId: userId);

    final RentalContract moving = await contracts.create(
      RentalContractDraft(
        customerId: people[5].id,
        trailerId: fleet[6].id,
        startAt: today,
        endAt: today.add(const Duration(days: 1, hours: 6)),
        pickupLocation: 'Hof Süd',
        returnLocation: 'Hof Süd',
        priceCents: 5900,
      ),
      userId: userId,
    );
    await contracts.handOver(moving.id, userId: userId);

    await contracts.create(
      RentalContractDraft(
        customerId: people[1].id,
        trailerId: fleet[2].id,
        startAt: today.add(const Duration(days: 3)),
        endAt: today.add(const Duration(days: 4)),
        pickupLocation: 'Hof Süd',
        returnLocation: 'Hof Nord',
        priceCents: 4500,
      ),
      userId: userId,
    );
    await contracts.create(
      RentalContractDraft(
        customerId: people[3].id,
        trailerId: fleet[3].id,
        startAt: today.add(const Duration(days: 7)),
        endAt: today.add(const Duration(days: 9)),
        pickupLocation: 'Hof Nord',
        returnLocation: 'Hof Nord',
        priceCents: 11900,
      ),
      userId: userId,
    );
    await contracts.create(
      RentalContractDraft(
        customerId: people[7].id,
        trailerId: fleet[7].id,
        startAt: today.add(const Duration(days: 10)),
        endAt: today.add(const Duration(days: 14)),
        pickupLocation: 'Baustelle Elbufer',
        returnLocation: 'Hof Nord',
        priceCents: 34900,
      ),
      userId: userId,
    );
    final RentalContract cancelled = await contracts.create(
      RentalContractDraft(
        customerId: people[2].id,
        trailerId: fleet[4].id,
        startAt: today.add(const Duration(days: 5)),
        endAt: today.add(const Duration(days: 6)),
        pickupLocation: 'Hof Nord',
        returnLocation: 'Hof Nord',
        priceCents: 9900,
      ),
      userId: userId,
    );
    await contracts.cancel(cancelled.id);
  }

  Future<void> _seedDamages(
    List<Trailer> fleet,
    List<Customer> people,
    int userId,
    DateTime now,
  ) async {
    final List<DamageRecordDraft> drafts = <DamageRecordDraft>[
      DamageRecordDraft(
        trailerId: fleet[0].id,
        eventDate: now.subtract(const Duration(days: 40)),
        description: 'Rückwärts in den Gartenzwerg des Nachbarn gesetzt.',
        damageType: DamageType.accident,
        causedBy: DamageCause.customer,
        customerId: people[0].id,
        costCents: 8900,
      ),
      DamageRecordDraft(
        trailerId: fleet[1].id,
        eventDate: now.subtract(const Duration(days: 12)),
        description: 'Reifen so glatt wie ein frisch gebohnertes Parkett.',
        damageType: DamageType.wear,
        causedBy: DamageCause.internal,
        costCents: 24000,
      ),
      DamageRecordDraft(
        trailerId: fleet[2].id,
        eventDate: now.subtract(const Duration(days: 75)),
        description:
            'Jemand hat „Hupen, wenn du mich magst“ auf die Bordwand gemalt.',
        damageType: DamageType.vandalism,
        causedBy: DamageCause.unknown,
      ),
      DamageRecordDraft(
        trailerId: fleet[3].id,
        eventDate: now.subtract(const Duration(days: 150)),
        description:
            'Eine Ziege hat die Plane angeknabbert. Die Ziege ist wohlauf.',
        damageType: DamageType.other,
        causedBy: DamageCause.unknown,
        costCents: 3550,
      ),
      DamageRecordDraft(
        trailerId: fleet[5].id,
        eventDate: now.subtract(const Duration(days: 5)),
        description: 'Der Rost hat inzwischen eigenen Rost angesetzt.',
        damageType: DamageType.wear,
        causedBy: DamageCause.internal,
        costCents: 41000,
      ),
      DamageRecordDraft(
        trailerId: fleet[6].id,
        eventDate: now.subtract(const Duration(days: 200)),
        description: 'Beim Einparken einen Poller sehr herzlich umarmt.',
        damageType: DamageType.accident,
        causedBy: DamageCause.customer,
        customerId: people[2].id,
        costCents: 15000,
      ),
    ];
    for (final DamageRecordDraft draft in drafts) {
      await damages.create(draft, userId: userId);
    }
  }

  int _priceFor(int fleetIndex, int days) {
    const List<int> dailyCents = <int>[
      3900,
      6900,
      4500,
      4900,
      8900,
      3500,
      4500,
      9900,
    ];
    return dailyCents[fleetIndex % dailyCents.length] * days;
  }

  static const List<_SampleTrailer> _sampleTrailers = <_SampleTrailer>[
    _SampleTrailer(
      code: 'BLITZ-01',
      plate: 'DD-AH 101',
      type: 'Pkw-Anhänger',
      address: 'Hof Nord, Stellplatz 3',
      latitude: 51.0834,
      longitude: 13.7350,
    ),
    _SampleTrailer(
      code: 'SCHNECKE-02',
      plate: 'DD-AH 102',
      type: 'Tieflader',
      address: 'Werkstatt, Halle 2',
    ),
    _SampleTrailer(
      code: 'OMA-03',
      plate: 'DD-AH 103',
      type: 'Kastenanhänger',
      address: 'Hof Süd, Stellplatz 1',
      latitude: 51.0270,
      longitude: 13.7290,
    ),
    _SampleTrailer(
      code: 'DONNERBUS-04',
      plate: 'DD-AH 104',
      type: 'Planenanhänger',
      address: 'Hof Nord, Stellplatz 7',
    ),
    _SampleTrailer(
      code: 'KRÜMEL-05',
      plate: 'DD-AH 105',
      type: 'Autotransporter',
      address: 'Hof Süd, hinter der Waschanlage',
    ),
    _SampleTrailer(
      code: 'ROSTI-06',
      plate: 'DD-AH 106',
      type: 'Pkw-Anhänger',
      address: 'Hof Nord, ganz hinten in der Ecke',
    ),
    _SampleTrailer(
      code: 'PIRAT-07',
      plate: 'DD-AH 107',
      type: 'Kastenanhänger',
      address: 'Hof Süd, Stellplatz 4',
    ),
    _SampleTrailer(
      code: 'MAMMUT-08',
      plate: 'DD-AH 108',
      type: 'Tieflader',
      address: 'Hof Nord, Schwerlastbereich',
      latitude: 51.0841,
      longitude: 13.7362,
    ),
  ];

  static const List<CustomerDraft> _sampleCustomers = <CustomerDraft>[
    CustomerDraft(
      firstName: 'Rainer',
      lastName: 'Zufall',
      email: 'rainer.zufall@example.de',
      phone: '0351 1234567',
      street: 'Am Holzweg 1',
      postalCode: '01067',
      city: 'Dresden',
      licenseNumber: 'B072RZ1980',
    ),
    CustomerDraft(
      firstName: 'Klara',
      lastName: 'Fall',
      email: 'klara.fall@example.de',
      phone: '0351 2345678',
      street: 'Sackgasse 7',
      postalCode: '01069',
      city: 'Dresden',
    ),
    CustomerDraft(
      firstName: 'Hein',
      lastName: 'Blöd',
      email: 'hein.bloed@example.de',
      phone: '03501 445566',
      street: 'Kurvenstraße 13',
      postalCode: '01796',
      city: 'Pirna',
    ),
    CustomerDraft(
      firstName: 'Ernst',
      lastName: 'Haft',
      email: 'ernst.haft@example.de',
      phone: '03521 778899',
      street: 'Zum Abschleppdienst 5',
      postalCode: '01662',
      city: 'Meißen',
      licenseNumber: 'B091EH1975',
    ),
    CustomerDraft(
      firstName: 'Wilma',
      lastName: 'Ruhe',
      email: 'wilma.ruhe@example.de',
      phone: '0351 9988776',
      street: 'Leise Gasse 2',
      postalCode: '01445',
      city: 'Radebeul',
    ),
    CustomerDraft(
      firstName: 'Mario',
      lastName: 'Nette',
      email: 'mario.nette@example.de',
      phone: '0351 1112223',
      street: 'Fadenweg 9',
      postalCode: '01099',
      city: 'Dresden',
    ),
    CustomerDraft(
      firstName: 'Anna',
      lastName: 'Nass',
      email: 'anna.nass@example.de',
      phone: '0351 4443332',
      street: 'Pfützenallee 4',
      postalCode: '01277',
      city: 'Dresden',
    ),
    CustomerDraft(
      firstName: 'Axel',
      lastName: 'Schweiß',
      email: 'axel.schweiss@example.de',
      phone: '0351 6665554',
      street: 'Muskelring 12',
      postalCode: '01309',
      city: 'Dresden',
      licenseNumber: 'C123AS1990',
    ),
  ];
}

class _SampleTrailer {
  const _SampleTrailer({
    required this.code,
    required this.plate,
    required this.type,
    required this.address,
    this.latitude,
    this.longitude,
  });

  final String code;
  final String plate;
  final String type;
  final String address;
  final double? latitude;
  final double? longitude;
}
