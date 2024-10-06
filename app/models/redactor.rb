class Redactor < ApplicationRecord
	self.table_name = "zargames.REDACTOR"
	self.primary_key = [:nickname_redactor]
	
	belongs_to :usuario, foreign_key: "nickname_redactor", primary_key: "nickname", class_name: "Usuario"
end