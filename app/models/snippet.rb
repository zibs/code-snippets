class Snippet < ActiveRecord::Base
  after_initialize :set_defaults
  belongs_to :user
  KIND_RUBY         = "Ruby"
  KIND_HTML         = "HTML"
  KIND_CSS          = "CSS"
  KIND_JAVASCRIPT   = "JavaScript"
  KINDS = [KIND_RUBY, KIND_HTML, KIND_CSS, KIND_JAVASCRIPT]

  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :title, presence: true, uniqueness: true
  validates :code, presence: true

  scope :recent, ->( number = 5){ order("created_at DESC").limit(number) }
  scope :public_snippet, -> {where({private: false})}
  scope :private_snippet, -> {where({private: true})}

   def set_defaults
    self.kind ||= KIND_RUBY
  end

end
