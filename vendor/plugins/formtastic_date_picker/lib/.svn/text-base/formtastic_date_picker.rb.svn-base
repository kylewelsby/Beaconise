module MeKyle
  module Formtastic
    module DatePicker
      
    protected
      def date_picker_input(method, options = {})
				# Lazy Option
				# string_input(method, options) +
				# time_input(method, date_picker_options(object.send(method)).merge(options))
				position = {:date => 1, :hour => 2, :minute => 3, :second => 4}
				inputs = options.delete(:order) || [:date]
				labels = options.delete(:labels) || {}
				time_inputs = [:hour, :minute]
				time_inputs << :second if options[:include_seconds]
				
				list_items_capture = ""
				
				datetime = options[:selected]
				datetime = @object.send(method) if @object && @object.send(method)
				
				html_options = options.delete(:input_html) || {}
				input_ids = []

				(inputs + time_inputs).each do |input|
					input_ids << input_id = generate_html_id(method, "#{position[input]}i")
					field_name = "#{method}(#{position[input]}i)"
					opts = strip_formtastic_options(options).merge(:prefix => @object_name, :field_name => field_name, :default => datetime)
					item_label_text = labels[input] || ::I18n.t(input.to_s, :default => input.to_s.humanize, :scope => [:datetime, :prompts])
					unless input == :date
						list_items_capture << template.content_tag(:li, 
							(!item_label_text.blank? ? template.content_tag(:label, item_label_text, :for => input_id) : "") +
							template.send(:"select_#{input}", datetime, opts, html_options.merge(:id => input_id))
						)
					else
						value = options[:value_method] || :id
						current_value = object.send(method).nil? ? '' : object.send(method).send(value)
						input_name = "#{@object_name}[#{field_name}]"
						list_items_capture << template.content_tag(:li, 
							(!item_label_text.blank? ? template.content_tag(:label, item_label_text, :for => input_id) : "") +
							# template.send(:text_field, method, :id => input_id)
							template.text_field_tag(input_name, current_value, :id => input_id)
						)
					end
				end
				field_set_and_list_wrapping_for_method(method, options.merge(:label_for => input_ids.first), list_items_capture)
      end
      

    end
  end
end