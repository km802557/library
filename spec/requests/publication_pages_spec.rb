require 'spec_helper'

describe "PublicationPages" do
   subject { page }

  let(:author) { FactoryGirl.create(:author) }
  before { sign_in author }

  describe "publication creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a publication" do
        expect { click_button "Post" }.not_to change(Publication, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_title('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'publication_title', with: "Lorem ipsum" }
      it "should create a publication" do
        expect { click_button "Post" }.to change(Publication, :count).by(1)
      end
    end
  end
end
