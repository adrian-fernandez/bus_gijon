module BusGijon
	class ClientAPI
		require 'net/http'
		require_relative './ws.rb'

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

		def self.post(url, params={})
			uri = URI(url)
			res = Net::HTTP.post_form(uri, params)

			return res.body
		end

	end
end
