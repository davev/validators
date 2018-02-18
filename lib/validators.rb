require "validators/version"

require "active_record"

require "validators/url_validator"
require "validators/email_validator"

module Validators
end

ActiveRecord::Base.send(:include, Validators)
