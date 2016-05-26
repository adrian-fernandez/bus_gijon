module BusGijon
	class EstadoParada  < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :idautobus, :idlinea, :idtrayecto, :minutos, :distancia, :utmx, :utmy, :horaactualizacion, :fechaactualizacion
		attr_accessor :idparada

		def initialize id_parada = nil
			self.idparada = id_parada

			load_data_from_ws unless self.idparada.nil? or self.idparada.blank?
		end

	private

		def get_estado_parada
			_url 	   = WS::URL.fetch('estado_parada')
			parameters = {:piIdParada => self.idparada}

			ClientAPI.get(_url, parameters)
		end

		def load_data_from_ws
			_hash_data = Hash.from_xml(get_estado_parada).fetch("autobuses", {}).fetch("autobus", {})
			load_values(_hash_data)
		end

		def load_values hash_data
			hash_data.keys.each do |key|
				attrib = "#{key}="
				self.send(attrib, hash_data.fetch(key))
			end
		end

	end
end

