require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin page" do
		before { visit signin_path }

		it { should have_selector('h1',    text: 'Sign in') }
		it { should have_selector('title', text: 'Sign in') }
	end
 
	describe "signin" do
		before { visit signin_path }

		describe "with invalid information" do
			let(:author) { FactoryGirl.create(:author) }
			before { sign_in author }

			it { should have_selector('title', text: author.nickname) }
			it { should have_link('Profile',  href: author_path(author)) }
			it { should have_link('Settings', href: edit_author_path(author)) }
			it { should have_link('Sign out', href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }
	     
			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end
   
		describe "with valid information" do
			let(:author) { FactoryGirl.create(:author) }
			before { sign_in author }

			it { should have_selector('title', text: author.nickname) }

			it { should have_link('Authors',    href: authors_path) }
			it { should have_link('Profile',  href: author_path(author)) }
			it { should have_link('Settings', href: edit_author_path(author)) }
			it { should have_link('Sign out', href: signout_path) }

			it { should_not have_link('Sign in', href: signin_path) }
     
			describe "followed by signout" do
				before { click_link "Sign out" }
				it { should have_link('Sign in') }
			end
		end
	end
  
  
	describe "authorization" do

		describe "for non-signed-in authors" do
			let(:author) { FactoryGirl.create(:author) }


			describe "when attempting to visit a protected page" do
				before do
					visit edit_author_path(author)
					fill_in "Nickname",    with: author.nickname
					fill_in "Password", with: author.password
					click_button "Sign in"
				end

				describe "after signing in" do

					it "should render the desired protected page" do
						page.should have_selector('title', text: 'Edit author')
					end
				end
			end

			describe "in the Publications controller" do

				describe "submitting to the create action" do
				  before { post publications_path }
				  specify { response.should redirect_to(signin_path) }
				end

				describe "submitting to the destroy action" do
				  before { delete publication_path(FactoryGirl.create(:publication)) }
				  specify { response.should redirect_to(signin_path) }
				end
			end
			describe "in the Authors controller" do

				describe "visiting the edit page" do
					before { visit edit_author_path(author) }
					it { should have_selector('title', text: 'Sign in') }
				end

				describe "submitting to the update action" do
					before { put author_path(author) }
					specify { response.should redirect_to(signin_path) }
				end
				
				describe "visiting the author index" do
					before { visit authors_path }
					it { should have_selector('title', text: 'Sign in') }
				end
				
				#~ describe "visiting the following page" do
					#~ before { visit following_user_path(user) }
					#~ it { should have_selector('title', text: 'Sign in') }
				#~ end

				#~ describe "visiting the followers page" do
					#~ before { visit followers_user_path(user) }
					#~ it { should have_selector('title', text: 'Sign in') }
				#~ end
			end
		end
		describe "as wrong author" do
			let(:author) { FactoryGirl.create(:author) }
			let(:wrong_author) { FactoryGirl.create(:author, nickname: "wrong") }
			before { sign_in author}

			describe "visiting Authors#edit page" do
				before { visit edit_author_path(wrong_author) }
				it { should_not have_selector('title', text: full_title('Edit author')) }
			end

			describe "submitting a PUT request to the Authors#update action" do
				before { put author_path(wrong_author) }
				specify { response.should redirect_to(root_path) }
			end
		end
		describe "as non-admin author" do
			let(:author) { FactoryGirl.create(:author) }
			let(:non_admin) { FactoryGirl.create(:author) }

			before { sign_in non_admin }

			describe "submitting a DELETE request to the Authors#destroy action" do
				before { delete author_path(author) }
				specify { response.should redirect_to(root_path) }        
			end
		end
	end
end
