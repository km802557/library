def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(author)
  visit signin_path
  fill_in "Nickname",    with: author.nickname
  fill_in "Password", with: author.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = author.remember_token
end
