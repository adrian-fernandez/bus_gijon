module BusGijon
	class InfoParada  < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idparada, :texto

	private

		def self.get_info_parada(id_parada)
			ClientAPI.get(WS::URL.fetch('info_parada') + id_parada)
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(InfoParada.get_trayectos).fetch('infos').fetch('infoparada')
			info_parada = AuxMethods.get_data_from_array(InfoParada, hash)

			return info_parada, :online
		end

	end
end

