module Oscal
  module CommonUtils
    def find_object_by_id(id, obj = self, attribute_name = :id)
      if obj.respond_to?(attribute_name) && obj.send(attribute_name) == id
        return obj
      end

      res = nil

      obj.instance_variables.each do |ins_var|
        val = obj.send(ins_var.to_s.delete('@').to_sym)

        if val.is_a? Array
          val.each do |v|
            res = find_object_by_id(id, v, attribute_name.to_sym)
            break unless res.nil?
          end
        else
          res = find_object_by_id(id, val, attribute_name.to_sym)
        end

        break unless res.nil?
      end

      res
    end

    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
    end
  end
end
