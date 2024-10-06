class Critica < ApplicationRecord
	self.table_name = "zargames.CRITICA"
	self.primary_key = "titulo_noticia"

	belongs_to :noticia, foreign_key: "titulo_noticia", primary_key: "titulo", class_name: "Noticia"
end