class Cpanel::ApplicationController < ApplicationController
	layout "cpanel"

	before_filter :authenticate_user!
	before_filter :cpanel_breadcrumb

	def cpanel_breadcrumb
		add_breadcrumb(t("cpanel.root"), cpanel_root_path)
	end
	
end
