module BusGijon
	class WS
		URL = {
			'linea' => 'http://docs.gijon.es/sw/busgijon.asmx/Lineas?',
			'parada' => 'http://docs.gijon.es/sw/busgijon.asmx/Paradas?',
			'horario' => 'http://docs.gijon.es/sw/busgijon.asmx/Horarios?',
			'llegada' => 'http://docs.gijon.es/sw/busgijon.asmx/LlegadasParadas?',
			'parada_trayecto' => 'http://docs.gijon.es/sw/busgijon.asmx/ParadasTrayectos?',
			'posicion' => 'http://docs.gijon.es/sw/busgijon.asmx/Posiciones?',
			'trayecto' => 'http://docs.gijon.es/sw/busgijon.asmx/Trayectos?',
			'estado_bus' => 'http://docs.gijon.es/sw/busgijon.asmx/estadoBus?psIdBus=',
			'estado_linea' => 'http://docs.gijon.es/sw/busgijon.asmx/estadoBus?piIdLinea=',
			'estado_parada' => 'http://docs.gijon.es/sw/busgijon.asmx/estadoParada?',
			'info_parada' => 'http://docs.gijon.es/sw/busgijon.asmx/infoParadas?psIdParada=',
			'estado_cabecera_salida' => 'http://docs.gijon.es/sw/busgijon.asmx/estadoCabeceraSalidas?psIdBus=%1%&psFechaHora=%2%',
			'salida_cabecera' => 'http://docs.gijon.es/sw/busgijon.asmx/salidasCabeceras'
		}
	end
end
