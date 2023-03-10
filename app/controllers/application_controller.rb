class ApplicationController < ActionController::Base
  layout :layout_by_resource

  protected

    def layout_by_resource
      puts "I'll sleep now 10/03/2023 1:19"
      if (devise_controller? && resource_class == Admin)
        'admin_devise'
      else
        'application'
      end
    end
end
