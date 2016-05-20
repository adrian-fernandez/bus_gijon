module BusGijon
	class SalidaCabecera < GenericBusGijonModel
		require_relative './../include/classes.rb'

		attr_accessor :dtfechainicio, :dtfechafin, :iidlinea, :iidtrayecto, :iordenenuhs, :dthorainicio, :inumeroexpedicion, :iordenentrayecto, :iidparada, :parada

	private

		def self.get_salida_cabecera(id_parada, fecha_hora)
			ClientAPI.get(WS::URL.fetch('salida_cabecera'))
		end

		def self.load_data_from_ws
			hash = Hash.from_xml(SalidaCabecera.get_salida_cabecera).fetch('salidas').fetch('salida')
			salida_cabecera = AuxMethods.get_data_from_array(SalidaCabecera, hash)

			return salida_cabecera, :online
		end

	end
end

