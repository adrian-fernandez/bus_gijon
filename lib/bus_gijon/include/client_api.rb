module BusGijon
# Clase encargada de realizar las peticiones al servicio web

# @author Adrián Fernández López {http://www.adrian-fernandez.net Página web} {mailto:adrian@adrian-fernandez.net E-Mail}
# @author   {https://github.com/adrian-fernandez/bus_gijon Código fuente en GitHub}
# @since 1.0.0
	class ClientAPI
		require 'net/http'
		require_relative './ws.rb'

		# Realiza petición GET por HTTP.
		# @since 1.0.0
		# @visibility public

		# @param [String] url URL del servicio a solicitar
		# @param [Hash] params Hash con los parámetros para enviar al servicio. Puede ser vacío

		# return [String] Respuesta del servidor en texto plano
		# @raise [TypeError] si la petición GET devuelve algún error
		def self.get(url, params={})
			uri = URI(url)
			uri.query = URI.encode_www_form(params)

			res = Net::HTTP.get_response(uri)

			if res.is_a?(Net::HTTPSuccess)
				return res.body
			else
				raise TypeError
			end
		end

		# Realiza petición POST por HTTP.
		# @since 1.0.0
		# @visibility public

		# @param [String] url URL del servicio a solicitar
		# @param [Hash] params Hash con los parámetros para enviar al servicio. Puede ser vacío

		# return [String] Respuesta del servidor en texto plano
		def self.post(url, params={})
			uri = URI(url)
			res = Net::HTTP.post_form(uri, params)

			return res.body
		end

	end
end
