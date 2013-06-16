require 'spec_helper'
require_relative '../../lib/tasks/selection_state_data_migrator'

describe SelectionStateDataMigrator do
  let!(:registration) { Fabricate(:registration) }

  before do
    registration.update_attribute(:selection_state, state)
  end

  context 'migrating weeklies' do
    let(:state) { "RGL Weeklies" }

    before { SelectionStateDataMigrator.migrate! }

    specify { expect(registration.reload.selection_state).to eq('weeklies') }
  end

  context 'migrating accepted' do
    let(:state) { "accepted" }

    before { SelectionStateDataMigrator.migrate! }

    specify { expect(registration.reload.selection_state).to eq("accepted") }
  end

  context 'migrating waiting list' do
    let(:state) { "waiting list" }

    before { SelectionStateDataMigrator.migrate! }

    specify do
      expect(registration.reload.selection_state).to eq("waiting_list")
    end
  end

  context "migrating accepted and attending" do
    let(:state) { "accepted" }

    before do
      registration.toggle!(:attending)
      SelectionStateDataMigrator.migrate!
    end

    specify { expect(registration.reload.selection_state).to eq("attending") }
  end
end
