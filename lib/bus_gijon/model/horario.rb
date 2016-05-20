module BusGijon
	class Horario  < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :fechainicio, :fechafin, :hora, :idlinea, :idtrayecto, :numeroexpedicion

	private

		def self.get_horarios()
			ClientAPI.get(WS::URL.fetch('horario'))
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(Horario.get_horarios).fetch('horarios').fetch('horario')
			horario = AuxMethods.get_data_from_array(Horario, hash)

			return horario, :online
		end

	end
end
