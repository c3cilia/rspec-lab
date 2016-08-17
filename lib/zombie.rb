class Zombie
	attr_accessor :name, :brains 
	def initialize  
		@name = "Ash"
		@brains = 0
	end 

	def hungry?
		true
	end 
end


class Tweet
  attr_accessor :status

  def initialize(options={})
    self.status = options[:status]
  end

  def public?
    self.status && self.status[0] != "@"                                 
  end

  def status=(status)
    @status = status ? status[0...140] : status
  end
end