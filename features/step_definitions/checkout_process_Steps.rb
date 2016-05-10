When(/^I navigate to the checkout page$/) do
  on(DetailsPage).view_details()
  on(PuppyDetailsPage).open_adoption_page
  on(PuppyItemsPage).loaded?
  on(PuppyItemsPage).complete_adoption
  on(CheckoutPage).loaded?
end

Given(/^I am on the puppy adoption site$/) do
  visit(DetailsPage)
end

When(/^I attempt to checkout for puppy "([^"]*)", without (?:a|an) "([^"]*)"$/) do |puppy_name, field|
  on(DetailsPage).view_details(puppy_name)
  on(PuppyDetailsPage).loaded?(puppy_name).should be true
  on(PuppyDetailsPage).open_adoption_page
  on(PuppyItemsPage).loaded?
  on(PuppyItemsPage).complete_adoption
  on(CheckoutPage).loaded?
  case field
    when 'Name'
      on(CheckoutPage).checkout('name' => '')
    when 'Address'
      on(CheckoutPage).checkout('address' => '')
  end
end

Then(/^I should see the error message "([^"]*)"$/) do |error_message|
  @browser.text.include?(error_message).should be true
  sleep 8
end


Then(/^I should see the following payment options:$/) do |table|
  # table is a table.hashes.keys # => [:pay_type]
  table.hashes .each do |hsh|
    on(CheckoutPage).pay_type_options.should include hsh['pay_type']
    end
end

When(/^I complete the adoption of a puppy$/) do
  on(DetailsPage).view_details()
  on(PuppyDetailsPage).open_adoption_page
  on(PuppyItemsPage).loaded?
  on(PuppyItemsPage).complete_adoption
  on(CheckoutPage).loaded?
  on(CheckoutPage).checkout()
end

# When (/^I complete the adoption for puppy "([^"]*)" with field "([^"]*)" with value "([^"]*)"$/) do |puppyName, checkoutField, checkoutValue|
#   on(DetailsPage).view_details(puppyName)
#   on(PuppyDetailsPage).open_adoption_page
#   on(PuppyItemsPage).loaded?
#   on(PuppyItemsPage).complete_adoption
#   on(CheckoutPage).loaded?
#   on(CheckoutPage).checkout()
# end

