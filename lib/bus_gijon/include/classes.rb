
#General purpose classes
require_relative './persistence.rb'
require_relative './client_api.rb'
require_relative './ws.rb'
require_relative './aux.rb'

#Models from API
require_relative './../model/generic_bus_gijon_model.rb'
require_relative './../model/linea.rb'
require_relative './../model/parada.rb'
require_relative './../model/horario.rb'
require_relative './../model/llegada.rb'
require_relative './../model/parada_trayecto.rb'
require_relative './../model/posicion.rb'
require_relative './../model/trayecto.rb'
require_relative './../model/estado_bus.rb'
require_relative './../model/estado_linea.rb'
require_relative './../model/estado_parada.rb'
require_relative './../model/info_parada.rb'
require_relative './../model/estado_cabecera_salida.rb'
require_relative './../model/salida_cabecera.rb'

#Exceptions
require_relative './../exception/local_data_not_found_exception.rb'
require_relative './../exception/required_param_missing_exception.rb'