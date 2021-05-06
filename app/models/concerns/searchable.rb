module Searchable

  extend ActiveSupport::Concern

  class_methods do
    def def_name_status_like(name, status)
      scope :name_status_like, -> (name, status) { where('name LIKE ?', "%#{name}%").where(status: status)}
    end
    def def_status_search(status)
      scope :status_like, -> (status) { where(status: status) }
    end    
    def def_columns_like(*columns)
      columns.each do |column|
        scope :"#{column}_like", -> (ward) {where('name LIKE ?', "%#{ward}%")}
      end
    end
  end
end