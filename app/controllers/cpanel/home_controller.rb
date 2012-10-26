class Cpanel::HomeController < Cpanel::ApplicationController

	def index
		set_page_tags(t("cpanel.pages.home.index"))
	end
	
end
