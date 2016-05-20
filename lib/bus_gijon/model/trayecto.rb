module BusGijon
	class Trayecto < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idtrayecto, :idlinea, :descripcion, :idcabecera, :direccion, :destino

	private

		def self.get_trayectos()
			ClientAPI.get(WS::URL.fetch('trayecto'))
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(Trayecto.get_trayectos).fetch('trayectos').fetch('trayecto')
			trayecto = AuxMethods.get_data_from_array(Trayecto, hash)

			return trayecto, :online
		end

	end
end

