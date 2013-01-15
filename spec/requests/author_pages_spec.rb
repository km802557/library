require 'spec_helper'

describe "Author pages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:author)
      FactoryGirl.create(:author, nickname: "nick", lastname: "Nick")
      FactoryGirl.create(:author, nickname: "john", lastname: "John")
      visit authors_path
    end

    it { should have_selector('title', text: 'All authors') }
    it { should have_selector('h1',    text: 'All authors') }

    it "should list each author" do
     Author.all.each do |author|
        page.should have_selector('li', text: author.nickname)
      end
    end
  end
  
  describe "profile page" do
    let(:author) { FactoryGirl.create(:author) }
    let!(:m1) { FactoryGirl.create(:publication, author: author, title: "Foo") }
    let!(:m2) { FactoryGirl.create(:publication, author: author, title: "Bar") }

    before { visit author_path(author) }

    it { should have_selector('h1',    text: author.nickname) }
    it { should have_selector('title', text: author.nickname) }

    describe "publications" do
      it { should have_title(m1.title) }
      it { should have_title(m2.title) }
      it { should have_title(author.publications.count) }
    end
  end
  
  
  
  describe "signup page" do
    let(:author) { FactoryGirl.create(:author) }
    before { visit author_path(author) }

    #~ it { should have_selector('h1',    text: author.lastname) }
    #~ it { should have_selector('title', text: author.nickname) }
    
    #~ before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }
  end
  
  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(Author, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Lastname",         with: "Example User"
	fill_in "Firstname",         with: "Example User"
        fill_in "Nickname",        with: "Example Nickname"
	fill_in "Labo",		with: "Example Labo"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a author" do
        expect { click_button submit }.to change(Author, :count).by(1)
      end
    end
  end
  
  
  describe "edit" do
    let(:author) { FactoryGirl.create(:author) }
    before { visit edit_author_path(author) }

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit author") }
      it { should have_link('change', href: 'http://gravatar.com/nicknames') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_title('error') }
    end
    
    describe "with valid information" do
      #~ let(:new_lastname)  { "New Lastname" }
      #~ let(:new_firstname)  { "New Firstname" }
      let(:new_nickname)  { "New Nickname" }
      before do
	fill_in "Nickname",		with: new_nickname 
	fill_in "Lastname",             with: new_lastname
        fill_in "Firstname",            with: new_firstname
        fill_in "Password",         with: author.password
        fill_in "Confirm Password", with: author.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_nickname) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { author.reload.nickname.should  == new_nickname }
    end
    
  end
end