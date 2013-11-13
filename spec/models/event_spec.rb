require 'spec_helper'

describe Event do
  let(:party) {
    PartyType.create(
      description: "Super fun party!"
    )
  }

  let(:rating) {
    Rating.create(
      name: "Super blush",
      value: 2
    )
  }

  let(:event) {
    Event.create(
      party_type_id: party.id,
      rating_id: rating.id
    )
  }

  it "should have a status automatically set to true" do
    event.should respond_to(:event_status)
    event.event_status.should == true
  end

  it "should automatically add a start time" do
    event.should respond_to(:start_time)
    event.start_time.should_not be_nil
  end

  it "should automatically add an end time" do
    event.should respond_to(:end_time)
    event.end_time.should_not be_nil
  end

  it "should have an end time 3 hours after end time" do
    event.end_time.should == event.start_time + 60 * 60 * 3
    (event.end_time.hour - event.start_time.hour).should == 3
  end

  it "should belong to party_type" do
    event.should respond_to(:party_type_id)
    event.party_type_id.should == party.id
    event.party_type.should == party
  end

  it "should belong to rating" do
    event.should respond_to(:rating_id)
    event.rating_id.should == rating.id
    event.rating.should == rating
  end

  it "should auto-assign a wordnik passphrase" do
    event.should respond_to(:wordnik)
    event.wordnik.should_not be_nil

    # make sure there are two words separated by a space
    event.wordnik.should include(" ")

    # make sure there are only two words
    event.wordnik.split(" ").length.should == 2
  end

end
