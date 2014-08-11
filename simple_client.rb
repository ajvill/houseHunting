#!/usr/bin/ruby

require 'logger'
module Log
	class  Log < Logger
		def initialize(args)
			super(args)
		end
	end
end

=begin
# Example how to declare log object and assign a level
log = Log::Log.new(STDOUT)
log.level = Log::Log::INFO

# Examples below to show 
log.fatal("Hey i'm fatal")
log.error("Hey i'm an error")
log.info("Hey i'm giving you info")
log.warn("Hey i'm a warning")
log.debug("Hey i'm a debug")
=end

# Main Loop of the program
# Setting Log level for the application
log = Log::Log.new(STDOUT)
log.level = Log::Log::DEBUG
log.debug("simple_client: log = #{log}")

## PUT CODE HERE:  This is what I am testing 
require './getLoc'
#test
citiesLoc = CitiesLoc.new(
					:log => log, 
				  	:state => "TX"
				 )



citiesLoc.getCities()
citiesLoc.to_file(:fileType => "xml")
sleep(2)

#test
countiesLoc = CountiesLoc.new(
					:log => log, 
				  	:state => "TX"
				 )
countiesLoc.getCounties()
countiesLoc.to_file(:fileType => "txt")
sleep(2)

#test
neighCityLoc = Neigh_City_Loc.new(
					:log => log, 
				  	:state => "TX", 
				  	:city => "Austin"
				 )
neighCityLoc.getNeighborhoodsInCity()
neighCityLoc.to_file(:fileType => "txt")

#test
statesLoc = StatesLoc.new(
					:log => log
				 )
statesLoc.getStates()
statesLoc.to_file(:fileType => "txt")

#test
zipCodesLoc = ZipCodesStateLoc.new(
					:log => log,
					:state => "TX"
				 )
zipCodesLoc.getZipCodesInState()
zipCodesLoc.to_file(:fileType => "txt")