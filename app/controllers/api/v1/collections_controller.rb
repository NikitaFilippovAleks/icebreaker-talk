# frozen_string_literal: true

module Api
  module V1
    class CollectionsController < ApplicationController
      before_action :find_collection, only: %i[show]

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

        render json: json_presented(@collections, 'collections', 'main')
      end

      def show
        render json: json_presented(@collection, 'collection', 'detailed')
      end

      def create
        result = Collection.create(collection_params)

        status, presenter_name =
          if result.valid?
            [:ok, 'detailed']
          else
            [:unprocessable_entity, 'data_errors']
          end

        render json: json_presented(result, 'collection', presenter_name, errors: result.errors),
               status:
      end

      def find_collection
        @collection = Collection.find_by(id: params[:id])
        not_found unless @collection
      end

      def collection_params
        params.require(:collection).permit(
          :name, :color, :description,
          questions: [[:text]]
        )
      end
    end
  end
end
