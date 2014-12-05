module SimpleForm
  module Components
    module Icons
      def icon
        return icon_class unless options[:icon].nil?
      end

      def icon_class
        icon_tag = template.content_tag(:i, '', class: options[:icon])
      end
    end

    module Tooltips
      def tooltip
        unless tooltip_text.nil?
          input_html_options[:rel] ||= 'tooltip'
          input_html_options['data-toggle'] ||= 'tooltip'
          input_html_options['data-placement'] ||= tooltip_position
          input_html_options['data-trigger'] ||= 'focus'
          input_html_options['data-original-title'] ||= tooltip_text
          nil
        end
      end

      def tooltip_text
        tooltip = options[:tooltip]
        tooltip.is_a?(String) ? tooltip : tooltip.is_a?(Array) ? tooltip[1] : nil
      end

      def tooltip_position
        tooltip = options[:tooltip]
        tooltip.is_a?(Array) ? tooltip[0] : "right"
      end
    end
  end

  module Inputs
    class FileInput < Base
      def input
        idf = "#{lookup_model_names.join("_")}_#{reflection_or_attribute_name}"
        input_html_options[:style] ||= 'display:none;'

        button = template.content_tag(:div, class: 'input-append') do 
          template.tag(:input, id: "pbox_#{idf}", class: 'string input-medium', type: 'text') +
          template.content_tag(:a, "Browse", class: 'btn', onclick: "$('input[id=#{idf}]').click();")
        end

        script = template.content_tag(:script, type: 'text/javascript') do
          "$('input[id=#{idf}]').change(function() { s = $(this).val(); $('#pbox_#{idf}').val(s.slice(s.lastIndexOf('\\\\\\\\')+1)); });".html_safe
        end

        @builder.file_field(attribute_name, input_html_options) + button + script
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Icons)
SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Tooltips)