module BusGijon
	class LocalDataNotFoundException < StandardError
	  attr_reader :model_name

	  def initialize(model_name, msg='Local stored data was not found')
	  	@model_name = model_name

	    super(msg)
	  end

	end
end