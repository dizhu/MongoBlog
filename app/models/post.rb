class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::CounterCache
  
  # fields
  field :title,               :type => String,  :default => ""
  field :entry_name,          :type => String,  :default => ""
  field :body,                :type => String,  :default => ""
  field :description,         :type => String,  :default => ""
  field :impressions_count,   :type => Integer, :default => 0
    
  # relations
  belongs_to :category
  
  # impressionist gem
  is_impressionable :counter_cache => true

  # mongoid-slug
  slug :entry_name do |post|
    if post.entry_name.blank?
      post.title.to_url
    else
      post.entry_name.to_url
    end
  end
  
  # counter-cache
  counter_cache :name => :category, :inverse_of => :posts

  # validates
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :title, length: { minimum: 2, maximum: 100 }, :unless => Proc.new { |post| post.title.blank? }
      
  validates :body, presence: true
  validates :category_id, presence: true
    
  validates :description, length: { maximum: 100 }, :unless => Proc.new { |post| post.description.blank? }
      
  validates :entry_name, uniqueness: true, :unless => Proc.new { |post| post.entry_name.blank? }
  validates :entry_name, length: { minimum: 2, maximum: 100 }, :unless => Proc.new { |post| post.entry_name.blank? }
  validates :entry_name, format: { with: /^(?!_)(?!.*?_$)[a-zA-Z0-9-]+$/ }, :unless => Proc.new { |post| post.entry_name.blank? }

  # scopes
  scope :latest, order_by(:created_at => :desc)
  scope :search, ->(title) { where(title: /.*#{title}.*/i) }
  
end
