#!/usr/bin/env ruby
require 'sinatra'
require 'redis'

set bind: '0.0.0.0', port: 4567

redis = Redis.new(
  host: ENV.fetch('REDIS_HOST', 'localhost'),
  port: ENV.fetch('REDIS_PORT', '6379').to_i
)

get '/' do
	<<~HTML
  <head>
    <style>
      body {
        background-color: #{redis.get('background')};
      }
    </style>
  </head

  <body>
    Super secret admin settings
    <form action="" method="post" class="form-example">
      <div>
        <label for="background">Choose a color: </label>
        <input 
          type="color" 
          id="background" 
          name="background" 
          value="#{redis.get('background')}"
        >
      </div>
      <div class="form-example">
        <input type="submit" value="Change the color">
      </div>
    </form>
  </body>
	HTML
end

post '/' do
  color = request['background']
  if color =~ /#[0-9a-fA-F]{6}/
    redis.set('background', color)
    redirect '/'
  end
  "<h1>Don't do that</h1>"
end
