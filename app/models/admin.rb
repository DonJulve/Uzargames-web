class Admin < ApplicationRecord
	self.table_name = "zargames.ADMIN"
	self.primary_key = [:nickname_admin]

	belongs_to :usuario, foreign_key: "nickname_admin", primary_key: "nickname", class_name: "Usuario"
end