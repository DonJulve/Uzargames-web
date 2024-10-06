class Noticia < ApplicationRecord
	self.table_name = "zargames.NOTICIA"
	self.primary_key = [:titulo]

	
	belongs_to :redactor, foreign_key: "nickname_redactor", primary_key: "nickname_redactor", class_name: "Redactor"
	belongs_to :admin, foreign_key: "nickname_admin", primary_key: "nickname_usuario", class_name: "Admin", optional: true
end