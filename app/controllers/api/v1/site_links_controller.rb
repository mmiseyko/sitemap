module Api
  module V1
    class SiteLinksController < ApplicationController
      def index
        render json: SiteLink.serialize_tree
      end

      def default_scope
        SiteLink.roots
      end
    end
  end
end
