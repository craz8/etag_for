module EtagFor
  class Railtie < ::Rails::Railtie

    initializer 'etag_for.initialize' do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :include, EtagFor
      end
    end

  end
end
