# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  lastname   :string(255)
#  firstname  :string(255)
#  labo       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Author do
  before { @author = Author.new(lastname: "Example Lastname", firstname: "Example Firstname", nickname: "Example Nickname", labo: "Example Labo", password: "foobar", password_confirmation: "foobar") }

  subject { @author}

  it { should respond_to(:lastname) }
  it { should respond_to(:firstname) }
  it { should respond_to(:nickname) }
  it { should respond_to(:labo) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }  
  it { should respond_to(:publications) }
  
  
  it { should be_valid }

  describe "when lastname is not present" do
    before { @author.lastname = " " }
    it { should_not be_valid }
  end

  describe "when firstname is not present" do
    before { @author.firstname = " " }
    it { should_not be_valid }
  end
  
  describe "when nickname is not present" do
    before { @author.nickname = " " }
    it { should_not be_valid }
  end
  
  describe "when labo is not present" do
    before { @author.labo = " " }
    it { should_not be_valid }
  end
  
  describe "when lastname is too long" do
    before { @author.lastname = "a" * 41 }
    it { should_not be_valid }
  end
  
    describe "when firstname is too long" do
    before { @author.firstname = "a" * 41 }
    it { should_not be_valid }
  end
  
  describe "when nickname is too long" do
    before { @author.nickname = "a" * 21 }
    it { should_not be_valid }
  end
  
    describe "when labo is too long" do
    before { @author.labo = "a" * 21}
    it { should_not be_valid }
  end

  
  
  describe "when nickname is already taken" do
    before do
      author_with_same_nickname = @author.dup
      author_with_same_nickname.nickname = @author.nickname.upcase
      author_with_same_nickname.save
    end

    it { should_not be_valid }
  end
  

it { should respond_to(:authenticate) }

describe "when password is not present" do
    before { @author.password = @author.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @author.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @author.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @author.password = @author.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

describe "remember token" do
    before { @author.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "publication associations" do

    before { @author.save }
    let!(:older_publication) do 
      FactoryGirl.create(:publication, author: @author, created_at: 1.day.ago)
    end
    let!(:newer_publication) do
      FactoryGirl.create(:publication, author: @author, created_at: 1.hour.ago)
    end

    it "should have the right publications in the right order" do
      @author.publications.should == [newer_publication, older_publication]
    end
    
    it "should destroy associated publications" do
      publications = @author.publications.dup
      @author.destroy
      publications.should_not be_empty
      publications.each do |publication|
        Publication.find_by_id(publication.id).should be_nil
      end
    end
    
    
  end
  
end
