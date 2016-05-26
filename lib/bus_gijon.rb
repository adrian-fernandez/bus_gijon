puts "A"

require_relative './bus_gijon/include/classes.rb'

require 'active_support/core_ext/hash'
require 'parallel'
require 'active_support/core_ext/string'
require 'byebug'

module BusGijon

	class BusGijon
		@_horarios 	   = nil
		@_lineas 		   = nil
		@_llegadas 	   = nil
		@_paradas 		   = nil
		@_paradatrayectos = nil
		@_salidacabeceras = nil
		@_trayectos 	   = nil

		@opts = {}

		def initialize(opts = {})
			@opts = GenericBusGijonModel::DEFAULT_OPTS.merge(opts)

			if @opts.fetch(:load_data, false)
				load_data(opts)
			end
		end

		def load_data(opts = {})
			@opts = GenericBusGijonModel::DEFAULT_OPTS.merge(opts)

			case @opts.fetch(:data, nil)
				when :static
					load_static_data(@opts)
				when :dynamic
					load_dynamic_data(@opts)
				when :all
					load_static_data(@opts)
					load_dynamic_data(@opts)
				else
					raise RequiredParamMissingException.new(:data)
			end
		end


		#Getter methods

		def horarios
			@_horarios = Trayecto.load_data if @_horarios.nil?
			return @_horarios
		end

		def lineas
			@_lineas = Trayecto.load_data if @_lineas.nil?
			return @_lineas
		end

		def llegadas
			@_llegadas = Trayecto.load_data if @_llegadas.nil?
			return @_llegadas
		end

		def paradas
			@_paradas = Trayecto.load_data if @_paradas.nil?
			return @_paradas
		end

		def paradatrayectos
			@_paradatrayectos = Trayecto.load_data if @_paradatrayectos.nil?
			return @_paradatrayectos
		end

		def salidacabeceras
			@_salidacabeceras = Trayecto.load_data if @_salidacabeceras.nil?
			return @_salidacabeceras
		end

		def trayectos
			@_trayectos = Trayecto.load_data if @_trayectos.nil?
			return @_trayectos
		end

		def horarios= value
			@_horarios = value
		end
		def lineas= value
			@_lineas = value
		end
		def llegadas= value
			@_llegadas = value
		end
		def paradas= value
			@_paradas = value
		end
		def paradatrayectos= value
			@_paradatrayectos = value
		end
		def salidacabeceras= value
			@_salidacabeceras = value
		end
		def trayectos= value
			@_trayectos = value
		end


	private


		def load_static_data(_opts)
			[Horario,
						  Linea,
						  Llegada,
						  Parada,
						  ParadaTrayecto,
						  Trayecto].each do |klass|
								klass_name = klass.to_s.gsub(/.*::/, "").parameterize.pluralize
								attrib = "#{klass_name}="

								value = klass.send(:load_data, _opts)

								puts "Asignado #{klass.to_s} a la variable #{attrib}"

								self.send(attrib, value)
							end
		end

		def load_dynamic_values(_opts)

		end

	end
end


#lineas = BusGijon::Parada.load_data()

#puts lineas.inspect
puts "B"

bus = BusGijon::BusGijon.new({:data => :static, :load_data => true})

puts bus.paradas.first.get_estado_parada.inspect

