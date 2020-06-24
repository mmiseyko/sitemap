# frozen_string_literal: true

class RelativePathValidator < ActiveModel::Validator
  def validate(record)
    return unless record.relative_path

    record.errors.add(:relative_path, :invalid_format) unless record.relative_path =~ relative_path_regex(record)
  end

  def start_slash_required?(record)
    record.ancestry.nil?
  end

  def relative_path_regex(record)
    record.ancestry.nil? ? %r{^(/|(/\w+)+)$} : %r{^(\w+(/\w+)*)*$}
  end
end
