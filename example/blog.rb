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
    This is my great webpage
  </body>
	HTML
end
