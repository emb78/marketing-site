require 'sinatra/base'

class Website < Sinatra::Base

  configure do
    def log message
      return unless Sinatra::Base.development?
      request.logger.info message
    end
  end

  get '/' do
    erb :home
  end
end

