module BusGijon
	class Llegada  < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idautobus, :matricula, :modelo, :idlinea, :idtrayecto, :idparada, :minutos, :distancia, :horaactualizacion, :fechaactualizacion

	private

		def self.get_llegada_paradas()
			ClientAPI.get(WS::URL.fetch('llegada'))
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(Llegada.get_llegada_paradas).fetch('llegadas').fetch('llegada')
			llegada = AuxMethods.get_data_from_array(Llegada, hash)

			return llegada, :online
		end

	end
end

