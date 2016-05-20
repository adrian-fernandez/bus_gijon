puts "A"

require_relative './bus_gijon/include/classes.rb'
require 'active_support/core_ext/hash'
require 'parallel'
require 'active_support/core_ext/string'
require 'byebug'

module BusGijon

	class BusGijon
		attr_accessor :horarios, :lineas, :llegadas, :paradas, :paradatrayectos, :salidacabeceras, :trayectos

		def initialize
		end

		def load_data(opts = {})
			opts = GenericBusGijonModel::DEFAULT_OPTS.merge(opts)

			case opts.fetch(:data, nil)
				when :static
					load_static_data(opts)
				when :dynamic
					load_dynamic_data(opts)
				when :all
					load_static_data(opts)
					load_dynamic_data(opts)
				else
					raise RequiredParamMissingException.new(:data)
			end
		end


	private


		def load_static_data(opts)
			Parallel.map([Horario,
						  Linea,
						  Llegada,
						  Parada,
						  ParadaTrayecto,
						  SalidaCabecera,
						  Trayecto]) do |klass|
								klass_name = klass.to_s.gsub(/.*::/, "").parameterize.pluralize
								attrib = "#{klass_name}="

								value = klass.send(:load_data, opts)

								self.send(attrib, value)
							end
		end

		def set_value variable, value
			attrib = "@#{variable}="
			self.send(attrib, value)
		end

		def load_dynamic_values(opts)

		end

	end
end


#lineas = BusGijon::Parada.load_data()

#puts lineas.inspect
puts "B"

bus = BusGijon::BusGijon.new
bus.load_data({:data => :static})
