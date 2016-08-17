require 'spec_helper'
require 'zombie'

describe Zombie do 
	it "is named Ash" do
		zombie = Zombie.new 
		expect(zombie.name).to eq("Ash")
	end 

	it "has no brains" do
		zombie = Zombie.new
		expect(zombie.brains).to be < 1
	end 

	it "is hungry" do 
		zombie = Zombie.new 
		expect(zombie).to be_hungry
	end 
end

describe Tweet do
  it "has a status of 'Nom nom nom'" do 
    tweet = Tweet.new
    tweet.status = "Nom nom nom"
    expect(tweet.status).to eq("Nom nom nom")
    
  end

  it 'without a leading @ symbol should be public' do
    tweet = Tweet.new(status: 'Nom nom nom')
    expect(tweet).to be_public
  end
  
  it 'truncates the status to 140 characters' do
    tweet = Tweet.new(status: 'Nom nom nom' * 100)
    expect(tweet.status.length).to be <= 140
  end
end
