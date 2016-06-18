# https://shivanithakur.wordpress.com/2015/03/04/how-to-make-active-admin-column-html_safe-and-replace-boolean-values-with-some-icons-in-better-way/
module ActiveAdmin
  module Views
    class TableFor
      def html_column(attribute)
        column(attribute){ |model| model[attribute].html_safe unless model[attribute].nil? }
      end

      def image_column(attribute)
        column(attribute) { |model| image_tag(model.send(attribute).url(:medium)) }
      end

      def bool_column(attribute)
        column(attribute){ |model| model[attribute] ? '✔'.html_safe : '✗'.html_safe }
      end
    end

    class AttributesTable
      def html_row(attribute)
        row(attribute){ |model| model[attribute].html_safe unless model[attribute].nil? }
      end

      def image_row(attribute)
        row(attribute){ |model| image_tag(model.send(attribute,).url(:medium)) }
      end

      def bool_row(attribute)
        row(attribute){ |model| model[attribute] ? '✔'.html_safe : '✗'.html_safe }
      end
    end
  end
end