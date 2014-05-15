require 'sinatra/base'
require 'sass'
require_relative 'asset_handler'
require 'pony'

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

  get '/pricing' do
    @css_files = :pricing
    erb :pricing
  end

  post '/quote_request' do

    request_info = ""
    params.keys.each do |k|
      request_info += "#{k} : #{params[k]}"
    end

    Pony.mail :to => 'admin@ecofirm.com',
              :subject => 'Incoming quote request',
              :body => request_info


    @css_files = :pricing
    @message = "Thank you for requesting a quote!"
    erb :pricing

  end
end

