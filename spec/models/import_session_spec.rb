require 'rails_helper'

describe ImportSession do
  describe 'Instance Methods >' do
    describe 'merge_into_membership >' do
      let(:m) { FactoryGirl.create(:membership) }

      it 'adds imported list when merge mode is merge' do
        imps = ImportSession.new(
          organization_id: m.organization_id,
          merge_mode: 'merge',
          list_text: "Brother Kite <brother_kite@gmail.com>\n"
        )
        imps.merge_into_membership
        expect(Membership.count).to eq 2
      end

      it 'replaces entire list when merge mode is replace' do
        imps = ImportSession.new(
          organization_id: m.organization_id,
          merge_mode: 'replace',
          list_text: "Brother Kite <brother_kite@gmail.com>\n"
        )
        imps.merge_into_membership
        expect(Membership.count).to eq 1
        expect(Membership.first.user_first_name).to eq 'Brother'
      end

      it 'imports lines of the form: first last <email>' do
        imps = ImportSession.new(
          organization_id: m.organization_id,
          merge_mode: 'replace',
          list_text: "Brother Kite <brother_kite@gmail.com>\n"
        )
        imps.merge_into_membership
        expect(Membership.count).to eq 1
        expect(Membership.first.user_first_name).to eq 'Brother'
        expect(Membership.first.user_last_name).to eq 'Kite'
        expect(Membership.first.user_email).to eq 'brother_kite@gmail.com'
      end

      it 'imports lines of the form: last, first <email>' do
        imps = ImportSession.new(
          organization_id: m.organization_id,
          merge_mode: 'replace',
          list_text: "Kite, Brother <brother_kite@gmail.com>\n"
        )
        imps.merge_into_membership
        expect(Membership.count).to eq 1
        expect(Membership.first.user_first_name).to eq 'Brother'
        expect(Membership.first.user_last_name).to eq 'Kite'
        expect(Membership.first.user_email).to eq 'brother_kite@gmail.com'
      end

      it 'imports lines of the form: first, last, email' do
        imps = ImportSession.new(
          organization_id: m.organization_id,
          merge_mode: 'replace',
          list_text: "Brother,  Kite,  brother_kite@gmail.com\n"
        )
        imps.merge_into_membership
        expect(Membership.count).to eq 1
        expect(Membership.first.user_first_name).to eq 'Brother'
        expect(Membership.first.user_last_name).to eq 'Kite'
        expect(Membership.first.user_email).to eq 'brother_kite@gmail.com'
      end

      it 'imports lines of the form: email' do
        imps = ImportSession.new(
          organization_id: m.organization_id,
          merge_mode: 'replace',
          list_text: "brother_kite@gmail.com\n"
        )
        imps.merge_into_membership
        expect(Membership.count).to eq 1
        expect(Membership.first.user_first_name).to eq ''
        expect(Membership.first.user_last_name).to eq ''
        expect(Membership.first.user_email).to eq 'brother_kite@gmail.com'
      end

      it 'reads line from a file' do
        extend ActionDispatch::TestProcess
        imps = ImportSession.new(
          organization_id: m.organization_id,
          merge_mode: 'replace',
          list_file: fixture_file_upload('membership_list.txt', 'text/plain')
        )
        imps.merge_into_membership
        expect(Membership.count).to eq 4
      end

      it "doesn't create users when they already exist" do
        imps = ImportSession.new(
          organization_id: m.organization_id,
          merge_mode: 'merge',
          list_text: "#{m.user_email}\n"
        )
        imps.merge_into_membership
        expect(User.count).to eq 1
        expect(Membership.count).to eq 1
      end
    end
  end
end
