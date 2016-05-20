module BusGijon
	class RequiredParamMissingException < StandardError
	  attr_reader :param_name

	  def initialize(param_name, msg="Requiered parameter is missing")
	  	@param_name = param_name

	    super(msg)
	  end

	end
end