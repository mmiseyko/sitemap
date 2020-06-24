# frozen_string_literal: true

module ArrangeSerializable
  extend ActiveSupport::Concern

  module ClassMethods
    def serialize_tree(options = {}, nodes = nil, parents = [])
      nodes = arrange(options) if nodes.nil?
      nodes.map do |parent, children|
        SiteLinkSerializer.new(parent, parents: parents).serializable_hash.merge(
          children: serialize_tree(options, children, parents + [parent])
        )
      end
    end
  end
end
