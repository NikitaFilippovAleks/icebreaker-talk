# frozen_string_literal: true

module Api
  module V1
    class CollectionsController < ApplicationController
      # Request for collections list
      #
      # @return [Hash] JSON
      #
      # @example get /api/v1/collections
      #
      # @example_return {
      #   collections:
      #     [
      #       {
      #         id: '320dbe3c-aadf-44d2-815e-2dffc1f3df89',
      #         name: 'Про общение',
      #           ...
      #       }
      #     ]
      #   }
      def index
        @collections = Collection.all

        render json: @collections
      end
    end
  end
end
