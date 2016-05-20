module BusGijon
	class EstadoParada  < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idautobus, :idlinea, :idtrayecto, :minutos, :distancia, :utmx, :utmy, :horaactualizacion, :fechaactualizacion

	private

		def self.get_estado_parada(id_parada)
			ClientAPI.get(WS::URL.fetch('estado_parada') + id_parada)
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(EstadoParada.get_trayectos).fetch('autobuses').fetch('autobus')
			estado_parada = AuxMethods.get_data_from_array(EstadoParada, hash)

			return estado_parada, :online
		end

	end
end

