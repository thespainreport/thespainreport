class Newsitem < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :regions
  has_and_belongs_to_many :stories
  belongs_to :article
  has_many :comments, as: :commentable, dependent: :destroy

  mount_uploader :main, MainUploader
  
  def to_param
  "#{id}-#{created_at.strftime("%y%m%d%H%M%S")}-update-#{slug.parameterize}"
  end
  
  scope :published, -> {where(status: ['published', 'updated'])}
  scope :lastfour, -> {order('created_at DESC').limit(4)}
  scope :lastfive, -> {order('created_at DESC').limit(5)}
  scope :lastsix, -> {order('created_at DESC').limit(6)}
  scope :lastten, -> {order('created_at DESC').limit(10)}
  scope :lasttwenty, -> {order('created_at DESC').limit(20)}
  scope :lastthirty, -> {order('created_at DESC').limit(30)}
  scope :lastfifty, -> {order('created_at DESC').limit(50)}
  scope :last24, -> {where(:created_at => 24.hours.ago..DateTime.now.in_time_zone)}
  
  alias_attribute :headline, :slug
  alias_attribute :body, :item
end
