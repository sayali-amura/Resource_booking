shared_examples "email validation" do |class_object|
		it "valid" do 
			class_object.email = "user@gmail.com"
			expect(class_object).to be_valid
		end
end