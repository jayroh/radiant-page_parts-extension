require_dependency 'application_controller'

class PagePartsExtension < Radiant::Extension
  version "0.9"
  description "Manage rich content through page parts"
  url "http://digitalpulp.com"

  def activate
    PagePart.send(:include, PageParts::PagePartExtensions)
    Page.send(:include, PageParts::PageExtensions, PageParts::PagePartTags)
    Admin::PagePartsController.send(:include, PageParts::ControllerExtensions)
    Admin::ResourceController.prepend_view_path "#{File.dirname(__FILE__)}/app/views"
    Admin::PagesController.helper PageParts::PagePartHelper
    ActiveSupport::Dependencies.load_paths << File.join(Rails.root, %w(app models))
  end

  def deactivate
  end

end
