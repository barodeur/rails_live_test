class ApplicationController < ActionController::Base
  include ActionController::Live

  protect_from_forgery with: :exception

  def homepage
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'

    sse = SSE.new(response.stream, retry: 100)

    begin
      loop do
        sse.write({ :time => Time.now })
        sleep 1
      end
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
    end
  end
end
