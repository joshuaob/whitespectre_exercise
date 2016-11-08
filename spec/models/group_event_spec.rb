require 'rails_helper'

RSpec.describe GroupEvent, type: :model do

  let(:group_event) { build(:group_event) }

  it "responds to name" do
    expect(group_event).to respond_to(:name)
  end

  it "responds to description" do
    expect(group_event).to respond_to(:description)
  end

  it "responds to starts_at" do
    expect(group_event).to respond_to(:starts_at)
  end

  it "responds to ends_at" do
    expect(group_event).to respond_to(:ends_at)
  end

  it "responds to location" do
    expect(group_event).to respond_to(:location)
  end

  it "responds to status" do
    expect(group_event).to respond_to(:status)
  end

  it "has a default status of draft" do
    group_event.save
    expect(group_event.status).to eq("draft")
  end

  it "cannot have an invalid status" do
    group_event.status = "arandomstatus"
    expect(group_event).to_not be_valid
  end

  it "responds to #publish!" do
    expect(group_event).to respond_to(:publish!)
  end

  it "responds to #mark_as_deleted!" do
    expect(group_event).to respond_to(:mark_as_deleted!)
  end

  it "is not marked as deleted by default" do
    group_event.save
    expect(group_event.deleted).to eq(false)
  end

  it "responds to .published" do
    expect(described_class).to respond_to(:published)
  end

  it "responds to .published_and_visible" do
    expect(described_class).to respond_to(:published_and_visible)
  end

  it "responds to duration" do
    expect(group_event).to respond_to(:duration)
  end

  it "updates the duration when saved without duration" do
    group_event = create(:group_event)
    group_event.save
    expect(group_event.duration).to eq(1)
  end

  it "updates the starts_at and ends_at time when saved without them" do
    group_event = create(:group_event, starts_at: nil, ends_at: nil, duration: 4)
    group_event.save
    expect(group_event.starts_at.day).to eq(Time.now.day)
    expect(group_event.ends_at.day).to eq((Time.now + 4.days).day)
  end

  it "is invalid when starts at is in the past" do
    group_event = build(:group_event, starts_at: Time.now - 1.day)
    expect(group_event).to_not be_valid
  end

  it "is invalid when ends at is in the past" do
    group_event = build(:group_event, ends_at: Time.now - 1.day)
    expect(group_event).to_not be_valid
  end

  it "is invalid when ends at is before starts at" do
    group_event = build(:group_event, ends_at: Time.now + 1.day, starts_at: Time.now + 2.days)
    expect(group_event).to_not be_valid
  end

  describe "#publish!" do

    context "when valid" do

      let!(:group_event) { create(:group_event) }

      it "returns true" do
        expect(group_event.publish!).to eq(true)
      end

      it "sets a group event status to published" do
        group_event.publish!
        expect(group_event.status).to eq("published")
      end

    end

    context "when invalid" do

      let!(:group_event) { create(:group_event, :invalid) }

      it "returns false" do
        expect(group_event.publish!).to eq(false)
      end

    end

    context "when name is not present" do

      let!(:group_event) { create(:group_event, name: nil) }

      it "is not valid to be published" do
        expect(group_event.valid?(:publish)).to eq(false)
      end

      it "has correct error pointing to name" do
        group_event.valid?(:publish)
        expect(group_event.errors.messages.keys).to include(:name)
      end

    end

    context "when description is not present" do

      let!(:group_event) { create(:group_event, description: nil) }

      it "is not valid to be published" do
        expect(group_event.valid?(:publish)).to eq(false)
      end

      it "has correct error pointing to description" do
        group_event.valid?(:publish)
        expect(group_event.errors.messages.keys).to include(:description)
      end

    end

    context "when starts_at is not present" do

      let!(:group_event) { create(:group_event, starts_at: nil) }

      it "is not valid to be published" do
        expect(group_event.valid?(:publish)).to eq(false)
      end

      it "has correct error pointing to starts_at" do
        group_event.valid?(:publish)
        expect(group_event.errors.messages.keys).to include(:starts_at)
      end

    end

    context "when ends_at is not present" do

      let!(:group_event) { create(:group_event, ends_at: nil) }

      it "is not valid to be published" do
        expect(group_event.valid?(:publish)).to eq(false)
      end

      it "has correct error pointing to ends_at" do
        group_event.valid?(:publish)
        expect(group_event.errors.messages.keys).to include(:ends_at)
      end

    end

    context "when location is not present" do

      let!(:group_event) { create(:group_event, location: nil) }

      it "is not valid to be published" do
        expect(group_event.valid?(:publish)).to eq(false)
      end

      it "has correct error pointing to location" do
        group_event.valid?(:publish)
        expect(group_event.errors.messages.keys).to include(:location)
      end

    end

  end

  describe "#mark_as_deleted!" do

    it "sets the deleted flag to true" do
      group_event = create(:group_event)
      group_event.mark_as_deleted!
      expect(group_event.deleted).to eq(true)
    end

  end

end
