require_relative './bus_gijon/classes.rb'
require 'active_support/core_ext/hash'


def create_object_from_hash(object_type, hash)
	obj = object_type.send(:new)

	for attribute in hash.keys
		assign_attribute = "#{attribute}="
		obj.send(assign_attribute, hash[attribute.to_s])
	end

	return obj
end

def get_data_from_array(object_type, array)
	data = []
	for element in array
		data << create_object_from_hash(object_type, element)
	end

	return data
end

lineas = BusGijon::Parada.load_data()

puts lineas.inspect
