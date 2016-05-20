module BusGijon
	class AuxMethods

		def self.create_object_from_hash(object_type, hash)
			obj = object_type.send(:new)

			for attribute in hash.keys
				assign_attribute = "#{attribute}="
				obj.send(assign_attribute, hash[attribute.to_s])
			end

			return obj
		end

		def self.get_data_from_array(object_type, array)
			data = []
			for element in array
				data << AuxMethods.create_object_from_hash(object_type, element)
			end

			return data
		end
	end
end