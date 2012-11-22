class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  
  before_save :update_image_attributes
  
  # fields
  field :title, 			  :type => String,  :default => ""
  field :description,   :type => String,  :default => ""
  field :image
  field :content_type,  :type => String,  :default => ""
  field :file_size,     :type => Integer, :default => 0
  
  attr_accessible :title, :description, :image
  
  # relations
  belongs_to :album
  
  # counter-cache
  counter_cache :name => :album, :inverse_of => :photos
  
  # carrierwave
  mount_uploader :image, ImageUploader
  
  # validates
  validates :image, presence: true

  validates :description, length: { maximum: 1000 }, :unless => Proc.new { |photo| photo.description.blank? }
  
  # scopes
  scope :latest, order_by(:created_at => :desc)
  
  private
  def update_image_attributes
    if image.present? && image_changed?
      self.content_type = MIME::Types.type_for(image.file.original_filename).first.to_s
      self.file_size = image.file.size
      self.title = image.file.basename.strip if title.blank?
    end
  end
  
end
