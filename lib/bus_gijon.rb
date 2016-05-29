puts 'A'

require_relative './bus_gijon/include/classes.rb'

require 'active_support/core_ext/hash'
require 'parallel'
require 'active_support/core_ext/string'
require 'byebug'

module BusGijon

# Clase base para el manejo de la API. Proporciona acceso a todos los datos.

# @author Adrián Fernández López {http://www.adrian-fernandez.net Página web} {mailto:adrian@adrian-fernandez.net E-Mail}
# @author   {https://github.com/adrian-fernandez/bus_gijon Código fuente en GitHub}
# @since 1.0.0
	class BusGijon
		@_horarios 	      = nil
		@_lineas 		      = nil
		@_llegadas 	      = nil
		@_paradas 		    = nil
		@_paradatrayectos = nil
		@_salidacabeceras = nil
		@_trayectos 	    = nil

		@opts = {}

    # Constructor de la clase. Inicializa la clase y carga todos los datos
    # @since 1.0.0
    # @visibility public
    # @param [Hash] opts opciones de configuración para la clase
    # @option opts [Boolean] :online Obtener la información del servicio web del Ayuntamiento de Gijón. En caso de ser false tratará de cargar una copia local de los datos
    # @option opts [Boolean] :save Guardar una copia local de los datos una vez obtenidos
    # @option opts [Boolean] :online_if_not_local Ignorar la opción :online = false y obtener los datos del servicio web cuando no se dispone de una copia local.
    # @option opts [Symbol] :load_data Especifica el tipo de datos que se quieren cargar inicialmente  (:static | :dynamic | :all)
    # @see GenericBusGijonModel#self.default_opts
    # return [void]
    # @raise [LocalDataNotFoundException] Cuando opts[:online]=false, opts[:online_if_not_local]=false y no se dispone de una copia local de los datos
    # @note opts[:load_data] => :static carga los datos: {BusGijon::Horario} {BusGijon::Linea} {BusGijon::Llegada} {BusGijon::Parada} {BusGijon::Trayecto} {BusGijon::ParadaTrayecto}
    # @note opts[:load_data] => :dynamic carga los datos:
    # @note opts[:load_data] => :all carga tanto datos estáticos como dinámicos
		def initialize(opts = {})
			@opts = GenericBusGijonModel::DEFAULT_OPTS.merge(opts)

			if @opts.fetch(:load_data, false)
				load_data()
			end
		end

    # Carga los datos sobre el servicio de autobuses.
    # @note Esta carga se puede ralizar desde el almacenamiento interno o desde el servicio web del Ayuntamiento de Gijón
    # @since 1.0.0
    # @visibility public

    # @param [Hash] opts Opciones de carga de datos (@see #initialize)
    # @see GenericBusGijonModel#self.default_opts
    # return [void]
    # @raise [RequiredParamMissingException] si el parámetro opts no tiene un valor :load_data válido (@see #initialize)
    def load_data(opts = {})
			@opts = GenericBusGijonModel::DEFAULT_OPTS.merge(opts)

			case @opts.fetch(:load_data, nil)
				when :static
					load_static_data(@opts)
				when :dynamic
					load_dynamic_data(@opts)
				when :all
					load_static_data(@opts)
					load_dynamic_data(@opts)
				else
					raise RequiredParamMissingException.new(:load_data)
			end
		end


		#Getter methods

    # Carga los datos sobre el servicio de autobuses.
    # @since 1.0.0
    # @visibility public
    # @see Horario
    # @return [Array<Horario>]
		def horarios
			@_horarios = Horario.load_data if @_horarios.nil?
			return @_horarios
		end

    # Carga los datos sobre las líneas del servicio de autobuses.
    # @since 1.0.0
    # @visibility public
    # @see Linea
    # @return [Array<Linea>]
		def lineas
			@_lineas = Linea.load_data if @_lineas.nil?
			return @_lineas
		end

    # Carga los datos sobre las llegadas de los autobuses.
    # @since 1.0.0
    # @visibility public
    # @see Llegada
    # @return [Array<Llegada>]
		def llegadas
			@_llegadas = Llegada.load_data if @_llegadas.nil?
			return @_llegadas
		end

    # Carga los datos sobre las paradas de autobús.
    # @since 1.0.0
    # @visibility public
    # @see Parada
    # @return [Array<Parada>]
		def paradas
			@_paradas = Parada.load_data if @_paradas.nil?
			return @_paradas
		end

    # Carga los datos sobre las paradas de los trayectos de los autobuses.
    # @since 1.0.0
    # @visibility public
    # @see ParadaTrayecto
    # @return [Array<ParadaTrayecto>]
		def paradatrayectos
			@_paradatrayectos = ParadaTrayecto.load_data if @_paradatrayectos.nil?
			return @_paradatrayectos
		end

    # Carga los datos sobre las cabeceras de salida de los autobuses.
    # @since 1.0.0
    # @visibility public
    # @see SalidaCabecera
    # @return [Array<SalidaCabecera>]
		def salidacabeceras
			@_salidacabeceras = SalidaCabecera.load_data if @_salidacabeceras.nil?
			return @_salidacabeceras
		end

    # Carga los datos sobre los trayectos de los autobuses
    # @since 1.0.0
    # @visibility public
    # @see Trayecto
    # @return [Array<Trayecto>]
    def trayectos
			@_trayectos = Trayecto.load_data if @_trayectos.nil?
			return @_trayectos
		end


    protected


    #Setter methods


    # Guarda los datos sobre los horarios de los autobuses
    # @note Si se inicializó con la opción (@see #initialize) :save => true guardará una copia en disco de este dato.
    # @since 1.0.0
    # @visibility protected
    # @see Horario
    # @param [Array<Horario>] value Datos para almacenar
    # return [void]
    def horarios= value
			@_horarios = value
		end

    # Guarda los datos sobre las líneas de los autobuses
    # @note Si se inicializó con la opción (@see #initialize) :save => true guardará una copia en disco de este dato.
    # @since 1.0.0
    # @visibility protected
    # @see Linea
    # @param [Array<Linea>] value Datos para almacenar
    # return [void]
		def lineas= value
			@_lineas = value
		end

    # Guarda los datos sobre las llegadas de los autobuses
    # @note Si se inicializó con la opción (@see #initialize) :save => true guardará una copia en disco de este dato.
    # @since 1.0.0
    # @visibility protected
    # @see Llegada
    # @param [Array<Llegada>] value Datos para almacenar
    # return [void]
		def llegadas= value
			@_llegadas = value
		end

    # Guarda los datos sobre las paradas de los autobuses
    # @note Si se inicializó con la opción (@see #initialize) :save => true guardará una copia en disco de este dato.
    # @since 1.0.0
    # @visibility protected
    # @see Parada
    # @param [Array<Parada>] value Datos para almacenar
    # return [void]
		def paradas= value
			@_paradas = value
		end

    # Guarda los datos sobre las paradas de los trayectos de los autobuses
    # @note Si se inicializó con la opción (@see #initialize) :save => true guardará una copia en disco de este dato.
    # @since 1.0.0
    # @see ParadaTrayecto
    # @param [Array<ParadaTrayecto>] value Datos para almacenar
    # return [void]
		def paradatrayectos= value
			@_paradatrayectos = value
		end

    # Guarda los datos sobre las cabeceras de salida de los autobuses
    # @note Si se inicializó con la opción (@see #initialize) :save => true guardará una copia en disco de este dato.
    # @since 1.0.0
    # @visibility protected
    # @see SalidaCabecera
    # @param [Array<SalidaCabecera>] value Datos para almacenar
    # return [void]
		def salidacabeceras= value
			@_salidacabeceras = value
		end

    # Guarda los datos sobre los trayectos de los autobuses
    # @note Si se inicializó con la opción (@see #initialize) :save => true guardará una copia en disco de este dato.
    # @since 1.0.0
    # @visibility protected
    # @see Trayecto
    # @param [Array<Trayecto>] value Datos para almacenar
    # return [void]
		def trayectos= value
			@_trayectos = value
		end


	private

    # Método para cargar los datos estáticos, es decir:
    #   @see Horario
    #   @see Linea
    #   @see Llegada
    #   @see Parada
    #   @see Trayecto
    #   @see ParadaTrayecto
    # @visibility private
    # @param [Hash] _opts Opciones de carga de datos (@see #initialize)
    # @see GenericBusGijonModel#default_opts
    # return [void]
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

