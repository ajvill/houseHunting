#require 'curb'
require './utils'

class TruliaAPI 
    include ApiKey
    include ToolBox

    attr_reader  :log, :apikey, :state 
    attr_accessor :dataObj, :funcCall

    def initialize(args={})
        @log = args[:log] || false
        @state = args[:state] || "TX"
        @funcCall = args[:funcCall] || false
        @dataObj = nil
        setApiKey
    end

    def getData
        log.debug("TruliaAPI::getData @funcCall = #{@funcCall}")
        c = Curl::Easy.perform("#{@funcCall}")
        c.perform
        now = Time.new.to_i
        @dataObj = c.body_str
    end

    def setApiKey
        @apiKey = get_apikey
        log.debug("TruliaAPI::setApiKey apikey = #{@apikey}")
    end

    def writeToFile (args={})
        body = @dataObj
        type = args[:type]
        fileType = args[:fileType]
        now = Time.new.to_i
        fileName = "./data/#{now}_#{type}_#{state}.#{fileType}"
        toFile(body, fileName)      #toFile is defined in ToolBox
    end 

    def exportData(args = {})
        writeToFile(args)
    end

end

class CitiesLoc < TruliaAPI

    attr_reader :cities #TODO need to create a cities object 

    def initialize(args={})
        super(args)
    end

    def getCities
       getCitiesInState 
    end

    def getCitiesInState
        @funcCall = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getCitiesInState&state=#{@state}&apikey=#{@apikey}"
        getData
        log.debug("CitiesLoc::getCities = #{@dataObj}")
    end

    def to_file(args={})
        fileType = args[:fileType]
        args = { :fileType => fileType, :type => "cities" }
        exportData(args)
    end
end

class CountiesLoc < TruliaAPI

    attr_reader :counties  #TODO need to create a counties object too

    def initialize(args={})
        super(args)
    end

    def getCounties
        getCountiesInState
    end

    def getCountiesInState
        @funcCall = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getCountiesInState&state=#{@state}&apikey=#{@apikey}"
        getData
        log.debug("CountiesLoc::getCountiesInState = #{@dataObj}")
    end

    def to_file(args={})
        fileType = args[:fileType]
        args = { :fileType => fileType, :type => "counties" }
        exportData(args)
    end
end
