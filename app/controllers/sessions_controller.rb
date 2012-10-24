class SessionsController < Devise::SessionsController
	layout "blank"

	def new
		set_page_tags(t("pages.login.title"), t("pages.login.keywords"), t("pages.login.description"))
	end

	def after_sign_in_path_for(resource_or_scope)
		cpanel_root_path
	end

end
