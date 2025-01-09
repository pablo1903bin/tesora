import 'package:image_picker/image_picker.dart';
import 'package:tesora/app/domain/models/cooperacion/cooperacion.dart';
import 'package:tesora/app/domain/models/gasto/gasto.dart';
import 'package:tesora/app/presentation/global/controller/boton_cargando_controller.dart';
import 'package:tesora/app/presentation/mixin/mixin_repositorios_comunes.dart';
import 'package:tesora/app/presentation/mixin/mmovil_repositorios.dart';
import 'package:tesora/app/presentation/modules/home/controllers/state/home_state.dart';

import '../../../../states/state_notifier.dart';

class HomeController extends StateNotifier<HomeState>
    with RepositoriosComunes, MmovilRepositorios {
  HomeController(super.state);

  Future<dynamic> reloadData() async {
    await Future.delayed(const Duration(seconds: 1));
    notifica(state.copyWith(totalCaja: 2350.50, ingresosTotal: 455.00), forzar: true);
    return state.totalCaja ?? 0.0;
  }

  Future<double> getIngresos() async {
    await Future.delayed(const Duration(seconds: 1));
    return state.totalCaja ?? 0.0;
  }

  Future<double> getGasto() async {
    await Future.delayed(const Duration(seconds: 1));
    return state.totalCaja ?? 0.0;
  }

  Future<double> getTotalcaja() async {
    await Future.delayed(const Duration(seconds: 1));
    return state.totalCaja ?? 0.0;
  }

// Simulación de una llamada API para obtener gastos.
  Future<List<dynamic>> getGastos() async {
    // Simulamos un retraso de 3 segundos como si fuera una llamada a una API
    await Future.delayed(const Duration(seconds: 1));

    List gastos = [];
    final gasto1 = Gasto(
      id: 1,
      nombre: "Compra de papelería",
      descripcion:
          "Compra de hojas y sobres para el evento anual y festividades de año nuevo y nuevo ciclo escolar, Compra de hojas y sobres para el evento anual y festividades de año nuevo y nuevo ciclo escolar, ",
      monto: 450.75,
      categoria: "Administración",
      fecha: DateTime(2024, 2, 5),
      estado: "Pagado",
      idUsuario: 1,
      idCategoria: 3,
      metodoPago: "Tarjeta",
      comprobante: "https://example.com/comprobante1.pdf",
      idGrupo: 101,
      participantes: [1, 2],
    );
    final gasto2 = Gasto(
      id: 1,
      nombre: "Reparación de mobiliario",
      descripcion: "Reparación de sillas y mesas de la sala de juntas",
      monto: 1200.00,
      categoria: "Mantenimiento",
      fecha: DateTime(2024, 2, 10),
      estado: "Pendiente",
      idUsuario: 2,
      idCategoria: 4,
      metodoPago: "Transferencia",
      comprobante: "https://example.com/comprobante2.pdf",
      idGrupo: 102,
      participantes: [3],
    );
    final gasto3 = Gasto(
      id: 1,
      nombre: "Compra de materiales de limpieza",
      descripcion: "Jabón, desinfectante y toallas para limpieza",
      monto: 300.50,
      categoria: "Limpieza",
      fecha: DateTime(2024, 2, 15),
      estado: "Pagado",
      idUsuario: 3,
      idCategoria: 5,
      metodoPago: "Efectivo",
      comprobante: "https://example.com/comprobante3.pdf",
      idGrupo: 103,
      participantes: [4, 5],
    );
    gastos.add(gasto1);
    gastos.add(gasto2);
    gastos.add(gasto3);
    return gastos;
  }

  // Simulación de una llamada API para obtener cooperaciones.
  Future<List<dynamic>> getCooperaciones() async {
    // Simulamos un retraso de 3 segundos como si fuera una llamada a una API
    await Future.delayed(const Duration(seconds: 1));
    List cooperaciones = [];

    final c = Cooperacion(
      nombre: "Cooperación Escolar",
      descripcion: "Recaudación para materiales educativos",
      montoObjetivo: "10000",
      fechaInicio: DateTime(2024, 1, 10),
      createdBy: 1,
      idGrupo: 101,
      idCategoria: 5,
      numeroCuenta: "1234567890123456",
      montoActual: 4500.0,
      participantes: [1, 2, 3],
      estado: "En progreso",
      tipoCooperacion: "Educativa",
      fechaCreacion: DateTime(2024, 1, 1),
    );
    final c2 = Cooperacion(
      nombre: "Cooperación para Deportes",
      descripcion: "Fondos para el equipo deportivo escolar",
      montoObjetivo: "5000",
      fechaInicio: DateTime(2024, 2, 5),
      createdBy: 2,
      idGrupo: 102,
      idCategoria: 6,
      numeroCuenta: "6543210987654321",
      montoActual: 2000.0,
      participantes: [4, 5],
      estado: "Pendiente",
      tipoCooperacion: "Deportiva",
      fechaCreacion: DateTime(2024, 1, 15),
    );
    final c3 = Cooperacion(
      nombre: "Cooperación Social",
      descripcion: "Recaudación para actividades sociales",
      montoObjetivo: "8000",
      fechaInicio: DateTime(2024, 3, 1),
      createdBy: 3,
      idGrupo: 103,
      idCategoria: 7,
      numeroCuenta: "1111222233334444",
      montoActual: 6500.0,
      participantes: [6, 7, 8],
      estado: "Completado",
      tipoCooperacion: "Social",
      fechaCreacion: DateTime(2024, 2, 1),
    );
    cooperaciones.add(c);
    cooperaciones.add(c2);
    cooperaciones.add(c3);
    return cooperaciones;
  }

  void cambioTab(int index) {
    print("Cambio de tab.... 😎 ${state.ingresoGasto}");
    notifica(state.copyWith(ingresoGasto: index));
  }

  Future<void> mostrarToast({String? msj}) async {
    nativeRepository.mostrarToast(msj: msj);
  }

  Future<String?> getUserName() async {
    final name = await getAuthenticationRepository.getNameUser();
    return name;
  }

  Future<void> capturarImagen() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {}
  }

  Future<int?> getLeverBattery() async {
    final porcentaje = await nativeRepository.obtenerPorcentajeCargaBateria();

    notifica(state.copyWith(level: porcentaje));
    return porcentaje;
  }

  Future<String?> getSoVersion() async {
    final so = await nativeRepository.getSOVersion();
    notifica(state.copyWith(version: so));
    return so;
  }

  void loading(bool cargar) {
    if (state.botonController != null) {
      if (cargar) {
        state.botonController!.cargando();
      } else {
        state.botonController!.normal();
      }
    }
  }

  void addBotonController(BotonCargandoController controller) {
    changeState(state.copyWith(botonController: controller));
  }
}
