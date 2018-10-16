# NOTE: WIP
module Jennifer
  module Postgres
    module Migration
      module TableBuilder
        class CreateMaterializedView < Base
           @query : QueryBuilder::Query | String

          def initialize(adapter, name, @query)
            super(adapter, name)
          end

          def process
            adapter.exec(generate_query)
          end

          private def generate_query
            if @query.is_a?(String)
              puts "String was used for describing source request of materialized  view. Use QueryBuilder::Query instead"
              @query.as(String)
            else
              String.build do |s|
                s <<
                  "CREATE MATERIALIZED VIEW " <<
                  @name <<
                  " AS " <<
                  adapter.sql_generator.select(@query.as(QueryBuilder::Query))
              end
            end
          end
        end
      end
    end
  end
end