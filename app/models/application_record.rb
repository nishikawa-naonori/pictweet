#ActiveRecordの中の Baseクラスを継承
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
