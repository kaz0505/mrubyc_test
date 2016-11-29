test_check "variable"

foobar = "foobar"
$foobar = foobar
test_ok($foobar == foobar)

#class Gods
#  @@rule = "Uranus"		# private to Gods
#  def ruler0
#    @@rule
#  end
#
#  def self.ruler1		# <= per method definition style
#    @@rule
#  end
#  class << self			# <= multiple method definition style
#    def ruler2
#      @@rule
#    end
#  end
#end
#
#module Olympians
#  @@rule ="Zeus"
#  def ruler3
#    @@rule
#  end
#end
#
#class Titans < Gods
#  @@rule = "Cronus"		# do not affect @@rule in Gods
#  include Olympians
#  def ruler4
#    @@rule
#  end
#end
#
#test_ok(Gods.new.ruler0 == "Cronus")
#test_ok(Gods.ruler1 == "Cronus")
#test_ok(Gods.ruler2 == "Cronus")
#test_ok(Titans.ruler1 == "Cronus")
#test_ok(Titans.ruler2 == "Cronus")
#atlas = Titans.new
#test_ok(atlas.ruler0 == "Cronus")
#test_ok(atlas.ruler3 == "Zeus")
#test_ok(atlas.ruler4 == "Cronus")
