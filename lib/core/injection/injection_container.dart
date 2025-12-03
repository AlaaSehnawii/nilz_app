import 'package:get_it/get_it.dart';
import 'package:nilz_app/feature/drawer/basic_data/bed_types/domain/usecase/add_bed_type_usecase.dart';
import 'package:nilz_app/feature/drawer/basic_data/bed_types/domain/usecase/bed_type_usecase.dart';
import 'package:nilz_app/feature/drawer/basic_data/bed_types/domain/usecase/delete_bed_type_usecase.dart';
import 'package:nilz_app/feature/drawer/basic_data/bed_types/domain/usecase/edit_bed_type_usecase.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/datasource/basic_data_remote.dart';
import 'package:nilz_app/feature/drawer/basic_data/data/repository/basic_data_repository.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/data/datasource/pending_req_remote.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/data/repository/pending_req_repository_impl.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/domain/repository/pending_req_repository.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/domain/usecase/pending_req_usecase.dart';
import 'package:nilz_app/feature/dashboard/pending_requests/presentation/cubit/pending_req_cubit.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/data/datasource/res_statistics_remote.dart';
import 'package:nilz_app/feature/dashboard/res_statistics/presentation/cubit/res_statistics_cubit.dart';
import 'package:nilz_app/feature/drawer/finance/gift/presentation/cubit/gift_cubit.dart';
import 'package:nilz_app/feature/posts/data/datasource/post_remote.dart';
import 'package:nilz_app/feature/posts/data/repository/post_repository_impl.dart';
import 'package:nilz_app/feature/posts/domain/repository/post_repository.dart';
import 'package:nilz_app/feature/posts/domain/usecase/create_post_usecase.dart';
import 'package:nilz_app/feature/posts/domain/usecase/post_usecase.dart';
import 'package:nilz_app/feature/posts/presentation/cubit/post_cubit.dart';
import 'package:nilz_app/feature/reservation/domain/usecase/unit_list_usecase.dart';
import 'package:nilz_app/feature/reservation/domain/usecase/create_reservation_usecase.dart';
import 'package:nilz_app/feature/reservation/domain/usecase/unit_usecase.dart';
import 'package:nilz_app/feature/reservation/presentation/cubit/unit_cubit.dart';
import '../../feature/auth/login/data/datasource/remote/auth_remote.dart';
import '../../feature/auth/login/data/repository/auth_repository_impl.dart';
import '../../feature/auth/login/domain/repository/auth_repository.dart';
import '../../feature/auth/login/domain/usecase/login_usecase.dart';
import '../../feature/auth/login/domain/usecase/logout_usecase.dart';
import '../../feature/auth/login/presentation/cubit/login_cubit/login_cubit.dart';
import '../../feature/drawer/basic_data/reservation_type/domain/usecase/add_reservation_type_usecase.dart';
import '../../feature/drawer/basic_data/reservation_type/domain/usecase/delete_reservation_type_usecase.dart';
import '../../feature/drawer/basic_data/reservation_type/domain/usecase/edit_reservation_type_usecase.dart';
import '../../feature/drawer/basic_data/reservation_type/domain/usecase/reservation_usecase.dart';
import '../../feature/drawer/basic_data/reservation_type/presentation/cubit/reservation_type_cubit.dart';
import '../../feature/drawer/basic_data/service/domain/usecase/add_service_usecase.dart';
import '../../feature/drawer/basic_data/service/domain/usecase/delete_service_usecase.dart';
import '../../feature/drawer/basic_data/service/domain/usecase/edit_service_usecase.dart';
import '../../feature/drawer/basic_data/service/domain/usecase/service_usecase.dart';
import '../../feature/drawer/basic_data/service/presentation/cubit/service_cubit.dart';
import '../../feature/drawer/basic_data/unit_types/domain/usecase/add_unit_type_usecase.dart';
import '../../feature/drawer/basic_data/unit_types/domain/usecase/delete_unit_type_usecase.dart';
import '../../feature/drawer/basic_data/bed_types/presentation/cubit/bed_type_cubit.dart';
import '../../feature/drawer/basic_data/city/domain/usecase/add_city_usecase.dart';
import '../../feature/drawer/basic_data/city/domain/usecase/city_usecase.dart';
import '../../feature/drawer/basic_data/city/domain/usecase/delete_city_usecase.dart';
import '../../feature/drawer/basic_data/city/domain/usecase/edit_city_usecase.dart';
import '../../feature/drawer/basic_data/city/presentation/cubit/city_cubit.dart';
import '../../feature/drawer/basic_data/place_types/domain/usecase/add_place_type_usecase.dart';
import '../../feature/drawer/basic_data/place_types/domain/usecase/delete_place_type_usecase.dart';
import '../../feature/drawer/basic_data/place_types/domain/usecase/edit_place_type_usecase.dart';
import '../../feature/drawer/basic_data/place_types/domain/usecase/place_type_usecase.dart';
import '../../feature/drawer/basic_data/place_types/presentation/cubit/place_type_cubit.dart';
import '../../feature/drawer/basic_data/data/repository/basic_data_repository_impl.dart';
import '../../feature/drawer/basic_data/post_category/domain/usecase/add_post_category_usecase.dart';
import '../../feature/drawer/basic_data/post_category/domain/usecase/delete_post_category_usecase.dart';
import '../../feature/drawer/basic_data/post_category/domain/usecase/edit_post_category_usecase.dart';
import '../../feature/drawer/basic_data/post_category/domain/usecase/post_category_usecase.dart';
import '../../feature/drawer/basic_data/post_category/presentation/cubit/post_category_cubit.dart';
import '../../feature/drawer/basic_data/room_types/domain/usecase/add_room_type_usecase.dart';
import '../../feature/drawer/basic_data/room_types/domain/usecase/delete_room_type_usecase.dart';
import '../../feature/drawer/basic_data/room_types/domain/usecase/edit_room_type_usecase.dart';
import '../../feature/drawer/basic_data/room_types/domain/usecase/room_type_usecase.dart';
import '../../feature/drawer/basic_data/room_types/presentation/cubit/room_type_cubit.dart';
import '../../feature/drawer/basic_data/unit_types/domain/usecase/edit_unit_type_usecase.dart';
import '../../feature/drawer/basic_data/unit_types/domain/usecase/unit_type_usecase.dart';
import '../../feature/drawer/basic_data/unit_types/presentation/cubit/unit_type_cubit.dart';
import '../../feature/dashboard/res_statistics/data/repository/res_statistics_repository_impl.dart';
import '../../feature/dashboard/res_statistics/domain/repository/res_statistics_repository.dart';
import '../../feature/dashboard/res_statistics/domain/usecase/res_statistics_usecase.dart';
import '../../feature/drawer/finance/data/datasource/finance_remote.dart';
import '../../feature/drawer/finance/data/repository/finance_repository.dart';
import '../../feature/drawer/finance/data/repository/finance_repository_impl.dart';
import '../../feature/drawer/finance/gift/domain/usecase/add_gift_usecase.dart';
import '../../feature/drawer/finance/gift/domain/usecase/delete_gift_usecase.dart';
import '../../feature/drawer/finance/gift/domain/usecase/edit_gift_usecase.dart';
import '../../feature/drawer/finance/gift/domain/usecase/gift_usecase.dart';
import '../../feature/drawer/finance/payment/domain/usecase/add_payment_usecase.dart';
import '../../feature/drawer/finance/payment/domain/usecase/delete_payment_usecase.dart';
import '../../feature/drawer/finance/payment/domain/usecase/edit_payment_usecase.dart';
import '../../feature/drawer/finance/payment/domain/usecase/payment_usecase.dart';
import '../../feature/drawer/finance/payment/presentation/cubit/payment_cubit.dart';
import '../../feature/reservation/data/datasource/reservation_remote.dart';
import '../../feature/reservation/data/repository/reservation_repository_impl.dart';
import '../../feature/reservation/domain/repository/reservation_repository.dart';
import '../../feature/reservation/domain/usecase/reservation_usecase.dart';
import '../../feature/reservation/presentation/cubit/reservation_cubit.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // ======= Auth =================
  sl.registerLazySingleton<AuthRemote>(() => AuthRemoteImpl());
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerFactory(() => LoginCubit(useCase: sl(), logoutUseCase: sl()));

  // ============ reservation statistics ===========
  sl.registerLazySingleton<ResStatisticsRemote>(
    () => ResStatisticsRemoteImpl(),
  );
  sl.registerLazySingleton<ResStatisticsRepository>(
    () => ResStatisticsRepositoryImpl(remote: sl()),
  );
  sl.registerLazySingleton<ResStatisticsUsecase>(
    () => ResStatisticsUsecase(repository: sl()),
  );
  sl.registerFactory<ResStatisticsCubit>(
    () => ResStatisticsCubit(usecase: sl()),
  );

  // ============ pending requests ===========
  sl.registerLazySingleton<PendingRequestRemote>(
    () => PendingRequestRemoteImpl(),
  );
  sl.registerLazySingleton<PendingRequestRepository>(
    () => PendingRequestRepositoryImpl(remote: sl()),
  );
  sl.registerLazySingleton<PendingRequestUseCase>(
    () => PendingRequestUseCase(repository: sl()),
  );
  sl.registerFactory<PendingRequestCubit>(
    () => PendingRequestCubit(usecase: sl()),
  );

  // ============ Reservation List ===========
  sl.registerLazySingleton<ReservationRemote>(() => ReservationRemoteImpl());
  sl.registerLazySingleton<ReservationRepository>(
    () => ReservationRepositoryImpl(remote: sl()),
  );
  sl.registerLazySingleton<ReservationUseCase>(
    () => ReservationUseCase(repository: sl()),
  );
  sl.registerLazySingleton<CreateReservationUseCase>(
    () => CreateReservationUseCase(repository: sl()),
  );
  sl.registerLazySingleton<UnitListUseCase>(() => UnitListUseCase(repository: sl()));
  sl.registerLazySingleton<UnitUseCase>(() => UnitUseCase(repository: sl()));
  sl.registerFactory<ReservationCubit>(
    () => ReservationCubit(useCase: sl(), createReservationUseCase: sl()),
  );
  sl.registerFactory<UnitCubit>(() => UnitCubit(unitListUseCase: sl(), unitUseCase: sl()));

  // ============ Post List ===========
  sl.registerLazySingleton<PostRemote>(() => PostRemoteImpl());
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(remote: sl()),
  );
  sl.registerLazySingleton<PostUseCase>(() => PostUseCase(repository: sl()));
  sl.registerLazySingleton<CreatePostUseCase>(
    () => CreatePostUseCase(repository: sl()),
  );
  sl.registerFactory<PostCubit>(
    () => PostCubit(useCase: sl(), createPostUseCase: sl()),
  );

  ///////////
  // ///////////////////////// Basic Data ////////////////////////////////
  //////////

  sl.registerLazySingleton<BasicDataRemote>(() => BasicDataRemoteImpl());
  sl.registerLazySingleton<BasicDataRepository>(
    () => BasicDataRepositoryImpl(remote: sl()),
  );

  // ==================== City List ==================
  sl.registerLazySingleton<CityUseCase>(() => CityUseCase(repository: sl()));
  sl.registerLazySingleton<DeleteCityUseCase>(
    () => DeleteCityUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddCityUseCase>(
    () => AddCityUseCase(repository: sl()),
  );
  sl.registerLazySingleton<EditCityUseCase>(
    () => EditCityUseCase(repository: sl()),
  );
  sl.registerFactory<CityCubit>(
    () => CityCubit(
      getCityUseCase: sl(),
      deleteCityUseCase: sl(),
      addCityUseCase: sl(),
      editCityUseCase: sl(),
    ),
  );

  // ============ Bed Type List ===========
  sl.registerLazySingleton<BedTypeUseCase>(
    () => BedTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeleteBedTypeUseCase>(
    () => DeleteBedTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddBedTypeUseCase>(
    () => AddBedTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<EditBedTypeUseCase>(
    () => EditBedTypeUseCase(repository: sl()),
  );
  sl.registerFactory<BedTypeCubit>(
    () => BedTypeCubit(
      getBedTypeUseCase: sl(),
      deleteBedTypeUseCase: sl(),
      addBedTypeUseCase: sl(),
      editBedTypeUseCase: sl(),
    ),
  );

  // ============ Room Type List ===========
  sl.registerLazySingleton<RoomTypeUseCase>(
    () => RoomTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeleteRoomTypeUseCase>(
    () => DeleteRoomTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddRoomTypeUseCase>(
    () => AddRoomTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<EditRoomTypeUseCase>(
    () => EditRoomTypeUseCase(repository: sl()),
  );
  sl.registerFactory<RoomTypeCubit>(
    () => RoomTypeCubit(
      getRoomTypeUseCase: sl(),
      deleteRoomTypeUseCase: sl(),
      addRoomTypeUseCase: sl(),
      editRoomTypeUseCase: sl(),
    ),
  );

  // ============ Place Type List ===========
  sl.registerLazySingleton<PlaceTypeUseCase>(
    () => PlaceTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeletePlaceTypeUseCase>(
    () => DeletePlaceTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddPlaceTypeUseCase>(
    () => AddPlaceTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<EditPlaceTypeUseCase>(
    () => EditPlaceTypeUseCase(repository: sl()),
  );
  sl.registerFactory<PlaceTypeCubit>(
    () => PlaceTypeCubit(
      getPlaceTypeUseCase: sl(),
      deletePlaceTypeUseCase: sl(),
      addPlaceTypeUseCase: sl(),
      editPlaceTypeUseCase: sl(),
    ),
  );

  // ============ Unit Type List ===========
  sl.registerLazySingleton<UnitTypeUseCase>(
    () => UnitTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeleteUnitTypeUseCase>(
    () => DeleteUnitTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddUnitTypeUseCase>(
    () => AddUnitTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<EditUnitTypeUseCase>(
    () => EditUnitTypeUseCase(repository: sl()),
  );
  sl.registerFactory<UnitTypeCubit>(
    () => UnitTypeCubit(
      getUnitTypeUseCase: sl(),
      deleteUnitTypeUseCase: sl(),
      addUnitTypeUseCase: sl(),
      editUnitTypeUseCase: sl(),
    ),
  );

  // ============ Post Category List ===========
  sl.registerLazySingleton<PostCategoryUseCase>(
    () => PostCategoryUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeletePostCategoryUseCase>(
    () => DeletePostCategoryUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddPostCategoryUseCase>(
    () => AddPostCategoryUseCase(repository: sl()),
  );
  sl.registerLazySingleton<EditPostCategoryUseCase>(
    () => EditPostCategoryUseCase(repository: sl()),
  );
  sl.registerFactory<PostCategoryCubit>(
    () => PostCategoryCubit(
      getPostCategoryUseCase: sl(),
      deletePostCategoryUseCase: sl(),
      addPostCategoryUseCase: sl(),
      editPostCategoryUseCase: sl(),
    ),
  );

  // ============ Reservation Type List ===========
  sl.registerLazySingleton<ReservationTypeUseCase>(
    () => ReservationTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeleteReservationTypeUseCase>(
    () => DeleteReservationTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddReservationTypeUseCase>(
    () => AddReservationTypeUseCase(repository: sl()),
  );
  sl.registerLazySingleton<EditReservationTypeUseCase>(
    () => EditReservationTypeUseCase(repository: sl()),
  );
  sl.registerFactory<ReservationTypeCubit>(
    () => ReservationTypeCubit(
      getReservationTypeUseCase: sl(),
      deleteReservationTypeUseCase: sl(),
      addReservationTypeUseCase: sl(),
      editReservationTypeUseCase: sl(),
    ),
  );

  // ============ Service List ===========
  sl.registerLazySingleton<ServiceUseCase>(
    () => ServiceUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeleteServiceUseCase>(
    () => DeleteServiceUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddServiceUseCase>(
    () => AddServiceUseCase(repository: sl()),
  );
  sl.registerLazySingleton<EditServiceUseCase>(
    () => EditServiceUseCase(repository: sl()),
  );
  sl.registerFactory<ServiceCubit>(
    () => ServiceCubit(
      getServiceUseCase: sl(),
      deleteServiceUseCase: sl(),
      addServiceUseCase: sl(),
      editServiceUseCase: sl(),
    ),
  );
  //////////////////////////////////////////////////

  /////////////////// Finance //////////////////////
  sl.registerLazySingleton<FinanceRemote>(() => FinanceRemoteImpl());
  sl.registerLazySingleton<FinanceRepository>(
    () => FinanceRepositoryImpl(remote: sl()),
  );

  // ============ Gift ===========
  sl.registerLazySingleton<GiftUseCase>(() => GiftUseCase(repository: sl()));
  sl.registerLazySingleton<DeleteGiftUseCase>(
    () => DeleteGiftUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddGiftUseCase>(
    () => AddGiftUseCase(repository: sl()),
  );
  sl.registerLazySingleton<EditGiftUseCase>(
    () => EditGiftUseCase(repository: sl()),
  );
  sl.registerFactory<GiftCubit>(
    () => GiftCubit(
      getGiftUseCase: sl(),
      deleteGiftUseCase: sl(),
      addGiftUseCase: sl(),
      editGiftUseCase: sl(),
    ),
  );

  // ============ Payment ===========
  sl.registerLazySingleton<PaymentUseCase>(
    () => PaymentUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeletePaymentUseCase>(
    () => DeletePaymentUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddPaymentUseCase>(
    () => AddPaymentUseCase(repository: sl()),
  );
  sl.registerLazySingleton<EditPaymentUseCase>(
    () => EditPaymentUseCase(repository: sl()),
  );
  sl.registerFactory<PaymentCubit>(
    () => PaymentCubit(
      getPaymentUseCase: sl(),
      deletePaymentUseCase: sl(),
      addPaymentUseCase: sl(),
      editPaymentUseCase: sl(),
    ),
  );
}
