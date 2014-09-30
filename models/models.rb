require 'active_record'
require 'active_support/all'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'default.db'
)

class User < ActiveRecord::Base
  has_many :submits

  validates :username, presence: true, uniqueness: true
  #validates :password, presence: true, length: { in: 8..20 }
end


class Submit < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :link, presence: true
  validates :text, presence: true
end

class Comment < ActiveRecord::Base
  belongs_to :submit

end
