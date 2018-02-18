class EmailValidator < ActiveModel::EachValidator
  DEFAULT_ERROR_MESSAGE = "please enter a valid email address".freeze

  def validate_each(record, attribute, value)
    unless value =~ /\A\S+@\S+\.\S+\z/i
      record.errors[attribute] << (options[:message] || DEFAULT_ERROR_MESSAGE)
    end
  end
end
