class Cpanel::HomeController < Cpanel::ApplicationController

	def index
		set_page_tags(t("cpanel.pages.home.index"))
		add_breadcrumb(t("cpanel.pages.home.index"))
	end
	
end
