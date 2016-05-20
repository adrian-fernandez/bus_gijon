module BusGijon
	class EstadoLinea < GenericBusGijonModel
		require_relative './../include/classes.rb'

#		attr_accessor :idparada, :idlinea, :idtrayecto, :minutos, :distancia, :horaactualizacion, :fechaactualizacion

	private

		def self.get_estado_linea(id_linea)
			ClientAPI.get(WS::URL.fetch('estado_linea') + id_linea)
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(EstadoLinea.get_trayectos).fetch('linea').fetch('trayecto')
### TODO ###
# trayectos + autobuses
# http://docs.gijon.es/sw/busgijon.asmx?op=estadoLinea
############

			estado_linea = AuxMethods.get_data_from_array(EstadoLinea, hash)

			return estado_linea, :online
		end

	end
end

