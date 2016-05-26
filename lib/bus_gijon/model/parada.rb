module BusGijon
	class Parada < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idparada, :descripcion, :utmx, :utmy

		def get_estado_parada
			estado = EstadoParada.new(self.idparada)
		end

	private

		def self.get_paradas()
			ClientAPI.get(WS::URL.fetch('parada'))
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(Parada.get_paradas).fetch('paradas').fetch('parada')
			parada = AuxMethods.get_data_from_array(Parada, hash)

			return parada, :online
		end
	end
end

