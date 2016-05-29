module BusGijon
	class EstadoCabeceraSalida < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idlinea, :idtrayecto, :minutos, :hora

	private

		def self.get_estado_cabecera_salida(id_parada, fecha_hora)
			url = WS::URL.fetch('estado_cabecera_salida')
			url = url.gsub('%1', id_parada)
			url = url.gsub('%2', fecha_hora)

			ClientAPI.get(url)
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(EstadoCabeceraSalida.get_trayectos).fetch('salidadeautobuses').fetch('salida')
			estado_cabecera_salida = AuxMethods.get_data_from_array(EstadoCabeceraSalida, hash)

			return estado_cabecera_salida, :online
		end

	end
end

