require 'rails_helper'

RSpec.describe "User Authentication", type: :system do
   describe "the signup process" do

      it "has a new user page" do
         visit new_user_url
         expect(page).to have_content "Register"
      end

      describe "signing up a user" do
         context "with valid user credentials" do
            before(:each) do
               visit new_user_url
               fill_in 'Email:', :with => "testing@email.com"
               fill_in 'Password:', :with => "biscuits"
               click_on "Sign up"
            end

            it "redirects to user account pending activation page after successful signup" do
               expect(page).to have_content "activation email"
            end
         end

         context "with invalid user credentials" do
            before(:each) do
               visit new_user_url
               fill_in 'Email', :with => "testing@email.com"
               click_on "Sign up"
            end

            it "re-renders the signup page after failed signup" do
               expect(page).to have_content "Register"
            end
         end
      end

   end

end