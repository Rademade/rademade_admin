# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      module Relations

        def relations
          @model_reflection.relations
        end

        def relation_exist?(name)

        end

        def relation(relation)

        end

        def association_foreign_key(rel)
          @model_reflection.association_foreign_key(rel)
        end

      end
    end
  end
end