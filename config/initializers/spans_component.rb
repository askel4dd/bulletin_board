module SimpleForm
  module Components
    module Spans
      def span(wrapper_options = nil)
        '<span class="input-group-addon"><span class="glyphicon glyphicon-asterisk"></span></span>'
      end
    end
  end
end
SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Spans)
