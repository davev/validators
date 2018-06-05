class UrlValidator < ActiveModel::EachValidator
  URL_FORMAT_REGEX = /\Ahttps?:\/\/[a-z0-9-]+\.\S+\z/i.freeze
  DEFAULT_ERROR_MESSAGE = "please enter a valid url, for example: http://www.your-domain.com".freeze

  def validate_each(record, attribute, value)
    unless value =~ URL_FORMAT_REGEX
      record.errors[attribute] << (options[:message] || DEFAULT_ERROR_MESSAGE)
    end
  end
end
