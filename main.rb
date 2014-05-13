require 'sinatra/base'
require 'sass'
require_relative 'asset_handler'

class Website < Sinatra::Base
  use AssetHandler

  configure do
    def log message
      return unless Sinatra::Base.development?
      request.logger.info message
    end
  end


  def css(*stylesheets)
    stylesheets.map do |stylesheet|
      "<link href=\"/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
    end.join
  end

  get '/' do
    @css_files = :home
    erb :home
  end

  get '/about' do
    @css_files = :about
    erb :about
  end
end

