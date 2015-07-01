# encoding: UTF-8
module Wice

  module Columns #:nodoc:

    class ViewColumnCheckboxRange < ViewColumn #:nodoc:

      def render_filter_internal(params) #:nodoc:
        #@contains_a_text_input = true
		#raise _.inspect
	
        @query,  _, parameter_name,  @dom_id  = form_parameter_name_id_and_query(fr: '')
        
        opts1 = {size: 2, id: @dom_id,  class: 'form-control input-sm '}
        
        if auto_reload
          opts1[:class] += ' auto-reload'
        end
		
		
			
		@ids = []
		@tag = ""
		@values.each do | k, v |
			@ids << parameter_name + "[#{v[0]}_#{v[1]}]"
			
			if params[:fr].present? and params[:fr]["#{v[0]}_#{v[1]}"].present? 
				@tag += content_tag(

					:div, content_tag(
						:label,	check_box_tag(parameter_name + "[#{v[0]}_#{v[1]}]", 1, true) + k
					), class: 'checkbox'
				)
			else
				@tag += content_tag(

					:div, content_tag(
						:label,	check_box_tag(parameter_name + "[#{v[0]}_#{v[1]}]", 1) + k
					), class: 'checkbox'
				)
			end
		end
		@tag
          
      end

      def yield_declaration_of_column_filter #:nodoc:
        {
          templates: [@query],
          ids:       @ids
        }
      end

      def has_auto_reloading_input? #:nodoc:
        auto_reload
      end
    end


    class ConditionsGeneratorColumnCheckboxRange < ConditionsGeneratorColumn  #:nodoc:

      def  generate_conditions(table_alias, opts)   #:nodoc:
        
		present_ranges = []
		
		conditions = []
		conditions[0] = []
		counter = 0
		query_collection = []
		
		opts[:fr].each do |k, v|
			value = k.split('_')
			conditions[0][counter] = []
			conditions[0][counter] << "( #{@column_wrapper.alias_or_table_name(table_alias)}.#{@column_wrapper.name} >= ? "
			
			conditions << value[0]
			conditions[0][counter] << " #{@column_wrapper.alias_or_table_name(table_alias)}.#{@column_wrapper.name} <= ? )"
			conditions << value[1]
			query_collection << conditions[0][counter].join(' and ')
			++counter
		end
		conditions[0] = query_collection.join(' or ')
        conditions
      end
    end
  end
end