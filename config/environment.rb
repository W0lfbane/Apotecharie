# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Apotecharie::Application.initialize!

ActiveRecord::Base.include_root_in_json = true

ActiveRecord::Base.include_root_in_json = true
