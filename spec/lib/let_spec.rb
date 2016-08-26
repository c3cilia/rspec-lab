require "car"
=begin

$count = 0
describe "let" do
  let(:count) { $count += 1 }

  it "memoizes the value" do
    expect(count).to eq(1)
    expect(count).to eq(1)
  end

  it "is not cached across examples" do
    expect(count).to eq(2)
  end
end
=end


=begin
$count = 0
describe "let!" do
  invocation_order = []

  let!(:count) do
    invocation_order << :let!
    $count += 1
  end

  it "calls the helper method in a before hook" do
    invocation_order << :example
    expect(invocation_order).to eq([:let!, :example])
    expect(count).to eq(1)
  end

  it "should just test" do
  	invocation_order << :example2
    expect(invocation_order).to eq([:let!, :example, :let!,:example2])
    expect(count).to eq(2)
  end
end
=end

describe Car do
	let(:my_car) {described_class.new}

	it "it is initially not be set to anything" do
		expect(my_car.speed).to eq(0)
	end 

	

end

