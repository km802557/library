require 'spec_helper'

describe "Static pages" do

  subject { page }
 
  describe "Home page" do

    it "should have the h1 'Library'" do
      visit root_path
      page.should have_selector('h1', text: 'Library')
    end

    it "should have the base title" do
      visit root_path
      page.should have_selector('title',
                        text: "Library")
    end

    it "should not have a custom page title" do
      visit root_path
      page.should_not have_selector('title', text: '| Home')
    end
  
    describe "for signed-in authors" do
      let(:author) { FactoryGirl.create(:author) }
      before do
        #~ FactoryGirl.create(:micropost, user: user, content: "Lorem")
        #~ FactoryGirl.create(:micropost, user: user, content: "Ipsum")
        sign_in author
        visit root_path
      end
      
      #~ it "should render the author's feed" do
        #~ user.feed.each do |item|
          #~ page.should have_selector("li##{item.id}", text: item.content)
        #~ end
      #~ end
      
      #~ describe "follower/following counts" do
        #~ let(:other_user) { FactoryGirl.create(:user) }
        #~ before do
          #~ other_user.follow!(user)
          #~ visit root_path
        #~ end
        
        #~ it { should have_link("0 following", href: following_user_path(user)) }
        #~ it { should have_link("1 followers", href: followers_user_path(user)) }
      #~ end
    end
  end
  
  describe "Help page" do
    
    it "should have the h1 'Help'" do
      visit help_path
      page.should have_selector('h1', text: 'Help')
    end
    
    it "should have the title 'Help'" do
      visit help_path
      page.should have_selector('title',
                        text: "Library | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About'" do
      visit about_path
      page.should have_selector('h1', text: 'About Us')
    end

    it "should have the title 'About Us'" do
      visit about_path
      page.should have_selector('title',
                    text: "Library | About Us")
    end
  end

  describe "Contact page" do

    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: 'Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title',
                    text: "Library | Contact")
    end
  end
end
