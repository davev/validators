class UrlValidator < ActiveModel::EachValidator
  DEFAULT_ERROR_MESSAGE = "please enter a valid url, for example: http://www.your-domain.com".freeze

  def validate_each(record, attribute, value)
    unless value =~ /\Ahttps?:\/\/[a-z0-9-]+\.\S+(?<!\.)\z/i
      record.errors[attribute] << (options[:message] || DEFAULT_ERROR_MESSAGE)
    end
  end
end
