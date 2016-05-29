module BusGijon
	class VialTrayecto < GenericBusGijonModel
		require_relative './../include/classes.rb'

#		attr_accessor :idvial_trayecto, :descripcion, :utmx, :utmy


### TODO
###
### => http://docs.gijon.es/sw/busgijon.asmx?op=vialesTrayecto
### 

	private

		def self.get_vial_trayectos
			ClientAPI.get(WS::URL.fetch('vial_trayecto'))
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(VialTrayecto.get_vial_trayectos).fetch('vialestrayectolinea').fetch('vial_trayecto')
			vial_trayecto = AuxMethods.get_data_from_array(VialTrayecto, hash)

			return vial_trayecto, :online
		end

	end
end

