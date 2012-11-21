class Album
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # fields
  field :title, 			:type => String,  :default => ""
  field :description, :type => String,  :default => ""
  field :photos_count, :type => Integer, :default => 0
  
  # relations
  has_many :photos
  
  # validates
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :title, length: { minimum: 2, maximum: 100 }, :unless => Proc.new { |category| category.title.blank? }

  validates :description, length: { maximum: 200 }, :unless => Proc.new { |category| category.description.blank? }
  
  # scopes
  scope :latest, order_by(:created_at => :desc)
  scope :search, ->(title) { where(title: /.*#{title}.*/i) }
  
end
