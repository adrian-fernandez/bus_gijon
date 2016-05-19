module BusGijon
	class Parada
		require_relative './client_api.rb'

		attr_accessor :idparada, :descripcion, :utmx, :utmy

		def self.get_paradas()
			BusGijon::ClientAPI.get(BusGijon::WS::URL.fetch('parada'))
		end

		def self.load_data()
			hash = Hash.from_xml(BusGijon::Parada.get_paradas).fetch('paradas').fetch('parada')
			parada = get_data_from_array(BusGijon::Parada, hash)

			return parada
		end

	private



	end
end

