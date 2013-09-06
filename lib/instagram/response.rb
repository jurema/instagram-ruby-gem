module Instagram
  module Response
    def self.create( response_hash, header_hash )
      data = response_hash.data.dup rescue response_hash
      data.extend( self )
      data.instance_exec do
        @pagination = response_hash.pagination
        @meta = response_hash.meta
        @reatelimit = ::Hashie::Mash.new(:limit => response.headers['x-ratelimit-limit'].to_i, :remaining => response.headers['x-ratelimit-remaining'].to_i)
      end
      data
    end

    attr_reader :pagination
    attr_reader :meta
    attr_reader :ratelimit
  end
end
