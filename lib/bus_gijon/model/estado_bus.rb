module BusGijon
	class EstadoBus < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idparada, :idlinea, :idtrayecto, :minutos, :distancia, :horaactualizacion, :fechaactualizacion

	private

		def self.get_estado_bus(id_bus)
			ClientAPI.get(WS::URL.fetch('estado_bus') + id_bus)
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(EstadoBus.get_trayectos).fetch('paradas').fetch('parada')
			estado_bus = AuxMethods.get_data_from_array(EstadoBus, hash)

			return estado_bus, :online
		end

	end
end

