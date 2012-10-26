class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  # fields
  field :title, 			:type => String,  :default => ""
  field :description, :type => String,  :default => ""
  field :entry_name,  :type => String,  :default => ""
  field :posts_count, :type => Integer, :default => 0
  
  # relations
  has_many :posts
  
  # mongoid-slug
  slug :entry_name do |category|
    if category.entry_name.blank?
      category.title.to_url
    else
      category.entry_name.to_url
    end
  end

  # validates
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :title, length: { minimum: 2, maximum: 100 }, :unless => Proc.new { |category| category.title.blank? }

  validates :description, length: { maximum: 200 }, :unless => Proc.new { |category| category.description.blank? }
  
  validates :entry_name, uniqueness: true, :unless => Proc.new { |category| category.entry_name.blank? }
  validates :entry_name, length: { minimum: 2, maximum: 100 }, :unless => Proc.new { |category| category.entry_name.blank? }
  validates :entry_name, format: { with: /^(?!_)(?!.*?_$)[a-zA-Z0-9-]+$/ }, :unless => Proc.new { |category| category.entry_name.blank? }

  # scopes
  scope :latest, order_by(:created_at => :desc)
  scope :search, ->(title) { where(title: /.*#{title}.*/i) }
  
  # callbacks
  # protected
end
