module BusGijon
# Clase genérica para manejar la información del servicio web
# Uso PRIVADO por el resto de clases de la librería, no debe ser llamada desde fuera.
#
# @author Adrián Fernández López {http://www.adrian-fernandez.net Página web} {mailto:adrian@adrian-fernandez.net E-Mail}
# @author   {https://github.com/adrian-fernandez/bus_gijon Código fuente en GitHub}
# @since 1.0.0
#	@visibility private
	class GenericBusGijonModel
		require_relative './../include/classes.rb'

		DEFAULT_OPTS = {
							:online 			 => false,
							:save   			 => true,
							:online_if_not_local => true,
							:load_data		 => :static
		}

		def initialize(*params)

		end

		# Devuelve las opciones por defecto para el módulo.
		# @see BusGijon#initialize
		# @return [Hash] opts opciones de configuración por defecto
		# 	:online => false
		# 	:save => true
		# 	:online_if_not_local => true
		# 	:load_data => :static
		def self.default_opts
			DEFAULT_OPTS
		end

		def self.load_data(opts = {})
			opts = DEFAULT_OPTS.merge(opts)

			if opts.fetch(:online)
				data, loaded = self.load_data_from_ws
			else
				begin
					data, loaded = Persistence.load(self)
				rescue LocalDataNotFoundException => _
					if opts.fetch(:online_if_not_local)
						data, loaded = self.load_data_from_ws
					else
						raise LocalDataNotFoundException.new(self)
					end
				end
			end

			if (loaded == :online) and opts.fetch(:save)
				Persistence.save(self, data)
			end 

			return data
		end

	private

	end

#	private_constant :GenericBusGijonModel

end

