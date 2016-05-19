module BusGijon
	class Linea
		require_relative './client_api.rb'

		attr_accessor :idlinea, :linea, :descripcion, :tipo, :codigo, :colorHex

		def self.get_lineas()
			BusGijon::ClientAPI.get(BusGijon::WS::URL.fetch('linea'))
		end

		def self.load_data()
			hash = Hash.from_xml(BusGijon::Linea.get_lineas).fetch('lineas').fetch('linea')
			linea = get_data_from_array(BusGijon::Linea, hash)

			return linea
		end

	private



	end
end
