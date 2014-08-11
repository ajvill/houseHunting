require './utils'

class TruliaAPI 
    include ApiKey
    include ToolBox

    attr_reader  :log, :apikey, :state 
    attr_accessor :dataObj, :funcCall
    def initialize(args={})
        @log = args[:log] || false
        @state = args[:state] || "USA"
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
        descr = args[:descr]
        fileType = args[:fileType]
        now = Time.new.to_i
        fileName = "./data/#{now}_#{descr}_#{state}.#{fileType}"
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
        args = { :fileType => fileType, :descr => "citiesLoc" }
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
        args = { :fileType => fileType, :descr => "countiesLoc" }
        exportData(args)
    end
end

class Neigh_City_Loc < TruliaAPI
    
    attr_reader :city

    def initialize(args={})
        super(args)
        @city = args[:city] || nil
    end
    
    def getNeighborhoodsInCity
        @funcCall = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getNeighborhoodsInCity&city=#{@city}&state=#{@state}&apikey=#{@apikey}"
        getData
        log.debug("Neigh_City_Loc::getNeighborhoodsInCity dataObj = #{@dataObj}")
    end

    def  to_file(args={})
        fileType = args[:fileType]
        args = { :fileType => fileType, :descr => "neigh_#{@city}" }
        exportData(args)
    end
end

class StatesLoc < TruliaAPI
    def initialize(args={})
        super(args)
    end
    
    def getStates
        @funcCall = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getStates&apikey=#{apikey}"
        getData
        log.debug("StatesLoc::getStates dataObj = #{@dataObj}")
    end
    
    def to_file(args={})
        fileType = args[:fileType]
        args = { :fileType => fileType, :descr => "statesLoc" }
        exportData(args)
    end
end

class ZipCodesStateLoc < TruliaAPI
    def initialize(args={})
        super(args)
    end

    def getZipCodesInState
        @funcCall = "http://api.trulia.com/webservices.php?library=LocationInfo&function=getZipCodesInState&state=#{state}&apikey=#{apikey}"
        getData
        log.debug("ZipCodesStateLoc::getZipCodesInState dataObj = #{@dataObj}")
    end

    def to_file(args={})
        fileType = args[:fileType]
        args = { :fileType => fileType, :descr => "zips" }
        exportData(args)
    end 
end