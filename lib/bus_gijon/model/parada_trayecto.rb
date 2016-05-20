module BusGijon
	class ParadaTrayecto < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idparada, :idlinea, :idtrayecto, :orden, :descripcion, :utmx, :utmy

	private

		def self.get_paradas_trayecto()
			ClientAPI.get(WS::URL.fetch('parada_trayecto'))
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(ParadaTrayecto.get_paradas_trayecto).fetch('paradastrayecto').fetch('parada')
			parada_trayecto = AuxMethods.get_data_from_array(ParadaTrayecto, hash)

			return parada_trayecto, :online
		end

	end
end

