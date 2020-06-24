# frozen_string_literal: true

class RelativePathValidator < ActiveModel::Validator
  def validate(record)
    return unless record.relative_path

    has_slash = has_slash?(record)
    if slash_allowed?(record)
      record.errors.add(:relative_path, :slash_required) unless has_slash
    else
      record.errors.add(:relative_path, :slash_not_allowed) if has_slash
    end
  end

  def slash_allowed?(record)
    record.ancestry.nil?
  end

  def has_slash?(record)
    record.relative_path.include?('/')
  end
end
