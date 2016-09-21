module ComplaintsHelper
def build_resourcelist
	@resources = Resource.all
	@arr = []
	@resources.each do |res|
	@arr << [res.name,res.id]
	end
	@arr
end
end
