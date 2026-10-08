import 'package:fluent_ui/fluent_ui.dart';

import '../core/design/widgets/app_state_views.dart';
import '../data/models/customer.dart';
import '../data/models/trailer.dart';
import '../data/repositories/trailer_repository.dart';
import 'app_dependencies.dart';

class Lookups {
  Lookups({required List<Customer> customers, required List<Trailer> trailers})
    : customers = <int, Customer>{
        for (final Customer customer in customers) customer.id: customer,
      },
      trailers = <int, Trailer>{
        for (final Trailer trailer in trailers) trailer.id: trailer,
      };

  final Map<int, Customer> customers;
  final Map<int, Trailer> trailers;

  String customerName(int? id) {
    if (id == null) {
      return '';
    }
    return customers[id]?.fullName ?? '#$id';
  }

  String trailerName(int? id) {
    if (id == null) {
      return '';
    }
    final Trailer? trailer = trailers[id];
    return trailer == null
        ? '#$id'
        : '${trailer.internalCode} (${trailer.licensePlate})';
  }
}

class LookupBuilder extends StatefulWidget {
  const LookupBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, Lookups lookups) builder;

  @override
  State<LookupBuilder> createState() => _LookupBuilderState();
}

class _LookupBuilderState extends State<LookupBuilder> {
  Stream<List<Customer>>? _customers;
  Stream<List<Trailer>>? _trailers;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppDependencies dependencies = AppScope.of(context);
    _customers ??= dependencies.customers.watchAll(includeArchived: true);
    _trailers ??= dependencies.trailers.watchAll(
      query: const TrailerQuery(includeArchived: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Customer>>(
      stream: _customers,
      builder: (BuildContext context, AsyncSnapshot<List<Customer>> customers) {
        return StreamBuilder<List<Trailer>>(
          stream: _trailers,
          builder:
              (BuildContext context, AsyncSnapshot<List<Trailer>> trailers) {
                if (customers.hasError || trailers.hasError) {
                  return const AppErrorState();
                }
                final List<Customer>? customerList = customers.data;
                final List<Trailer>? trailerList = trailers.data;
                if (customerList == null || trailerList == null) {
                  return const AppLoadingState();
                }
                return widget.builder(
                  context,
                  Lookups(customers: customerList, trailers: trailerList),
                );
              },
        );
      },
    );
  }
}
