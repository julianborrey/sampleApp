require 'spec_helper'

describe "Static pages" do

  ###############   Page Mechanics Tests #################
  subject { page }
  
  describe "Home page" do
    before { visit root_path } #much like a loop

    it { should have_content('Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
         FactoryGirl.create(:micropost, user: user, content: "yo world")
         FactoryGirl.create(:micropost, user: user, content: "yo page")
         sign_in user
         visit root_path
       end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
  
  
  ######## Checking Links are Correctly Mapped ########
  describe "Static pages" do
    it "should have the right links to the layout" do
      visit root_path

      click_link "About" #go to page and click link
      expect(page).to have_title(full_title('About Us')); #check CURRENT page now has the correct title
      
      click_link "Help"
      expect(page).to have_title(full_title('Help'));
      
      click_link "Contact"
      expect(page).to have_title(full_title('Contact'));
      expect(page).to have_content('about the sample'); #fragment of text
      
      click_link "Home" #we are actually traversing. goes to home first
      click_link "Sign up now!" #then goes to this button
      expect(page).to have_title(full_title('Sign up'));
      
      click_link "sample app"
      expect(page).to have_title(full_title(''));
    end
  end

end
