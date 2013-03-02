require 'socket'

class LyricThiefController < ApplicationController
  def index
  end

  def display
    @artist = params[:artist]
    @song = params[:song_name]

    host = Socket.gethostname
    port = 915
    @result = ''

    begin
      s = TCPSocket.new host, port
    rescue
    end

    s.puts("{ \"artist\" : \"#{@artist}\", \"song\" : \"#{@song}\"}")

    begin
      while line = s.gets   # Read lines from the socket
       @result +=  line.chop + "\n"      # And print with platform line terminator
      end
    rescue
    end
    s.close               # Close the socket when done

  end
end
