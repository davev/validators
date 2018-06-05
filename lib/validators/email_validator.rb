class EmailValidator < ActiveModel::EachValidator
  EMAIL_FORMAT_REGEX = /\A\S+@\S+\.\S+(?<!\.)\z/i.freeze
  DEFAULT_ERROR_MESSAGE = "please enter a valid email address".freeze

  def validate_each(record, attribute, value)
    unless value =~ EMAIL_FORMAT_REGEX
      record.errors[attribute] << (options[:message] || DEFAULT_ERROR_MESSAGE)
    end
  end
end
