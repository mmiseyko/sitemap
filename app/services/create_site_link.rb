# frozen_string_literal: true

class CreateSiteLink
  include Callable

  attr_reader :attrs

  def initialize(attrs)
    @attrs = attrs.dup
  end

  def call
    parent_name = attrs.delete(:parent)
    parent = parent_name.present? ? SiteLink.find_by!(name: parent_name) : nil

    site_link = SiteLink.find_or_initialize_by(attrs)
    site_link.update!(parent: parent)
  end
end
