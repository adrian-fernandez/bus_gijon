module BusGijon
	class GenericBusGijonModel
		require_relative './../include/classes.rb'

		DEFAULT_OPTS = {
							:online 			 => false,
							:save   			 => true,
							:online_if_not_local => true
		}

		def initialize *params

		end

		def self.load_data(opts = {})
			opts = DEFAULT_OPTS.merge(opts)

			if opts.fetch(:online)
				data, loaded = self.load_data_from_ws
			else
				begin
					data, loaded = Persistence.load(self)
				rescue LocalDataNotFoundException => e
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
end

