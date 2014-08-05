#require 'curb'
require './utils'

class TruliaAPI 
    include ApiKey
    #include WriteToFile
    include ToolBox

    attr_reader  :log, :apikey, :state

    def initialize(args={})
        @log = args[:log] || false
        @state = args[:state] || "TX"
        @funcCall = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getCitiesInState&state=#{@state}&apikey=#{@apikey}"
        setApiKey
        getCities
    end

    def getCitiesInState
        c = Curl::Easy.perform("#{@funcCall}")
        c.perform
        now = Time.new.to_i
        fileName = "./data/#{now}_#{@state}_cities.xml"
        toFile(c.body_str, fileName)
    end

    def getCities
        getCitiesInState
    end

    def setApiKey
        @apiKey = get_apikey
    end 
end

class CitiesLoc < TruliaAPI
    attr_reader  :log, :apikey, :state, :funcCall
    def initialize(args={})
        @log = args[:log] || false
        @state = args[:state] || "TX"
        @funcCall = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getCitiesInState&state=#{@state}&apikey=#{@apikey}"
        setApiKey
        getCities
    end

end

=begin
class CitiesLoc
    include ApiKey
    #include WriteToFile
    include ToolBox

    attr_reader  :log, :apikey, :state, :funcCall

    def initialize(args={})
        @log = args[:log] || false
        @state = args[:state] || "TX"
        @funcCall = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getCitiesInState&state=#{@state}&apikey=#{@apikey}"
        setApiKey
        getCities
    end

    def getCitiesInState
        c = Curl::Easy.perform("#{@funcCall}")
        c.perform
        now = Time.new.to_i
        fileName = "./data/#{now}_#{@state}_cities.xml"
        toFile(c.body_str, fileName)
    end

    def getCities
        getCitiesInState
    end

    def setApiKey
        @apiKey = get_apikey
    end
end
=end

class CountiesLoc
    include ApiKey
    include ToolBox

    attr_reader :log, :apikey, :state, :funcCall

    def initialize(args={})
        @log = args[:log] || false
        @state = args[:state] || "TX"
        @funcCall = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getCountiesInState&state=#{@state}&apikey=#{@apikey}"
        setApiKey
        getCounties
    end

    def getCountiesInState
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

