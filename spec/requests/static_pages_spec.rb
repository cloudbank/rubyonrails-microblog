require 'spec_helper'
describe "StaticPages" do
  let(:base_title) { "My Rails Sample App" }
  subject { page }
  describe "Home page" do
    before { visit root_path }
    it { should have_selector('h2', :text => 'Welcome') }
    it { should have_selector('title',:text => "#{base_title}")}
    it { should_not have_selector('title', :text => '| Home') }
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end
      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end
  describe "Help page" do
    #comment
    before {visit help_path }
    it { should have_selector('h1', :text => 'Help')}
    it { should have_selector('title',:text => "#{base_title} | Help")}
  end
  describe "About page" do
    before {visit about_path }
    it { should have_selector('h1', :text => 'About Me')}
    it { should have_selector('title',:text => "#{base_title} | About Me")}
  end
  describe "Contact page" do
    before {visit contact_path }
    it { should have_selector('h1', text: 'Contact')}
    it { should have_selector('title',
                              text: "#{base_title} | Contact")}
  end
end
