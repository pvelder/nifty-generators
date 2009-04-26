Given /^I have <%= plural_name %>? titled (.*)$/ do |<%= plural_name %>|
  <%= plural_name %>.split(', ').each do |<%= singular_name %>|
    Factory(:<%= singular_name %>, :subject => <%= singular_name %>)
  end

end

Then /^I should see (.*) <%= plural_name %>?$/ do |count|
  <%= class_name %>.count.should == count.to_i
end

Given /^I have no <%= plural_name %>$/ do
  <%= class_name %>.delete_all
end  
