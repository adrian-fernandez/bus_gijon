module BusGijon
# Clase para el manejo de horarios de los autobuses
#
# @author Adrián Fernández López (https://www.github.com/adrian-fernandez)
# @since 1.0.0

# @attr [DateTime] fechainicio Fecha y hora de inicio del servicio del autobús
# @attr [DateTime] fechafin Fecha y hora de finalización del servicio del autobús
# @attr [Time] hora ¿?
# @attr [Number] idlinea Identificador de la línea a la que sirve el autobús (@see Linea)
# @attr [Number] idtrayecto Identificador del trayecto que está realizando el autobús (@see Trayecto)
# @attr [Number] numeroexpedicion Número de expedición del autobús

	class Horario  < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :fechainicio, :fechafin, :hora, :idlinea, :idtrayecto, :numeroexpedicion

	private

		def self.get_horarios
      ClientAPI.get(WS::URL.fetch('horario'))
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(Horario.get_horarios).fetch('horarios').fetch('horario')
			horario = AuxMethods.get_data_from_array(Horario, hash)

			return horario, :online
		end

	end
end
