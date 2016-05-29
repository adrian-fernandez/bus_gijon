module BusGijon
	class Posicion < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idautobus, :matricula, :modelo, :idlinea, :idtrayecto, :idparada, :ordenparada, :utmx, :utmy, :horaactualizacion, :fechaactualizacion, :idsiguienteparada, :minutos, :distancia

	private

		def self.get_posiciones
			ClientAPI.get(WS::URL.fetch('posicion'))
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(Posicion.get_posiciones).fetch('posiciones').fetch('posicion')
			posicion = AuxMethods.get_data_from_array(Posicion, hash)

			return posicion, :online
		end


	end
end

