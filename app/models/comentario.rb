class Comentario < ApplicationRecord
	self.table_name = "zargames.COMENTARIO"
	self.primary_key = [:id_comentario]

	belongs_to :usuario, foreign_key: "nickname_usuario", primary_key: "nickname", class_name: "Usuario"
	belongs_to :noticia, foreign_key: "titulo_noticia", primary_key: "titulo", class_name: "Noticia"
end