class Valoracion < ApplicationRecord
	self.table_name = "zargames.VALORACION"
	self.primary_key = [:titulo_noticia,:nickname_usuario]

	belongs_to :usuario, foreign_key: "nickname_usuario", primary_key: "nickname", class_name: "Usuario"
	belongs_to :noticia, foreign_key: "titulo_noticia", primary_key: "titulo", class_name: "Noticia"
end