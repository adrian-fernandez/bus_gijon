module BusGijon
	class Linea  < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idlinea, :linea, :descripcion, :tipo, :codigo, :colorHex

	private

		def self.get_lineas()
			ClientAPI.get(WS::URL.fetch('linea'))
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(Linea.get_lineas).fetch('lineas').fetch('linea')
			linea = AuxMethods.get_data_from_array(Linea, hash)

			return linea, :online
		end

	end
end
