module ApiKey
    FILENAME = "./apikey.txt"
    attr_accessor  :apikey

    def get_apikey
        file = File.open("#{FILENAME}", "r")
        file.each_line do |line|
            @apikey = line
        end
        file.close
        @apikey
    end
end

module ToolBox
    require 'curl'

    module GetData
        def getData
             c = Curl::Easy.perform("#{@funcCall}")
             c.perform
             now = Time.new.to_i
             fileName = "./data/#{now}_#{@state}_counties.xml"
             log.debug("toXML, filename = #{fileName}")
             toFile(c.body_str, fileName)
         end
     
         def getCounties
             getCountiesInState
         end
         def setApiKey
             @apiKey = get_apikey
             log.debug("apikey = #{@apikey}")
         end 
    end

    module WriteToFile
        def toFile(data, fileName)
            File.open("#{fileName}", "w") { |file| file.write("#{data}") }
        end
    end
    include WriteToFile
end
