class Publication < ActiveRecord::Base
  attr_accessible :title
  belongs_to :author
  
  validates :author_id, presence: true
  default_scope order: 'publications.created_at DESC'
end
