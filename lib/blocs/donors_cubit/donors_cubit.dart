import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'donors_state.dart';

class DonorsCubit extends Cubit<DonorsState> {
  DonorsCubit() : super(DonorsInitial());
}
