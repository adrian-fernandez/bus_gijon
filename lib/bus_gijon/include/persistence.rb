module BusGijon
# Clase encargada de la gestión de la copia local de los datos proporcionados por el servicio.

# @author Adrián Fernández López {http://www.adrian-fernandez.net Página web} {mailto:adrian@adrian-fernandez.net E-Mail}
# @author   {https://github.com/adrian-fernandez/bus_gijon Código fuente en GitHub}
# @since 1.0.0
	class Persistence
		require 'pstore'

		# Guarda los datos en el almacenamiento local.
		# @since 1.0.0
		# @visibility public

		# @param [Class] model Clase de los datos que se quieren guardar
		# @param [Hash] data Datos para almacenar
		# return [true]
		def self.save(model, data)
			store = PStore.new("#{model.to_s}.pstore")
			store.transaction do
				store[:data] = data
			end

			true
		end

		# Guarda los datos en el almacenamiento local.
		# @since 1.0.0
		# @visibility public

		# @param [Class] model Clase de los datos que se quieren guardar
		# return [model, :local] Devuelve un objeto del tipo model o Array<model> con los datos almacenados, además del símbolo :local indicando que los datos se leyeron de forma local.
		# @raise [LocalDataNotFoundException] si no hay datos almacenados del modelo solicitado
		def self.load(model)
			store = PStore.new("#{model.to_s}.pstore")

			value = store.transaction { store.fetch(:data, nil) }

			if value.nil?
				raise LocalDataNotFoundException.new(model)
			else
				return value, :local
			end
		end

	end
end
