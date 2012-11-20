module ApplicationHelper

    def wrap_control_group(&block)
    content_tag(:div, class: "row-fluid") do
      content_tag(:div, class: "span6 bgcolor") do
        content_tag(:div, class: "control-group") do
          yield
        end
      end
    end
  end

end
