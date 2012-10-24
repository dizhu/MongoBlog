class Setting
  include Mongoid::AppSettings

  setting :cpanel_page_size, :default => 2
end
