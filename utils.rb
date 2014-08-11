
#GET_CITIES = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getCitiesInState&state=#{@state}&apikey=#{@apikey}"
#GET_COUNTIES  = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getCountiesInState&state=#{@state}&apikey=#{@apikey}" 

module ApiKey
    FILENAME = "./apikey.txt"
    attr_accessor  :apikey

    def get_apikey
        file = File.open("#{FILENAME}", "r")
        file.each_line do |line|
            @apikey = line
        end
        file.close
        log.debug("ApiKey::get_apikey apikey = #{@apikey}")
        @apikey
    end
end

module ToolBox
    require 'curb'

    module File_Utils
        def toFile(data, fileName)
            File.open("#{fileName}", "w") { |file| file.write("#{data}") }
        end
    end
    include File_Utils
end
