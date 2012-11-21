class Setting
  include Mongoid::AppSettings

  setting :cpanel_page_size, :default => 10
  setting :cpanel_album_page_size, :default => 12
end
