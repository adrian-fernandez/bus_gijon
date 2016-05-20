module BusGijon
	class Persistence
		require "pstore"

		def self.save(model, data)
			store = PStore.new("#{model.to_s}.pstore")
			store.transaction do
				store[:data] = data
			end

			true
		end

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
