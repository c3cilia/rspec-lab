require "shared_example"
describe Car do
	let(:my_car) {described_class.new}

	it "it is initially not be set to anything" do
		expect(my_car.speed).to eq(0)
	end 
end
