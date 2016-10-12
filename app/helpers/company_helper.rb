module CompanyHelper
	def humanizing timing
  		hour = timing.strftime("%H")
  		minute = timing.strftime("%M")
  		"#{hour.to_i}:#{minute.to_i}"
  	end
end
