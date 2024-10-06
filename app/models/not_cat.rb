class NotCat < ApplicationRecord
	self.table_name = "zargames.NOT_CAT"
	self.primary_key = [:titulo_noticia,:nombre_categoria]

	belongs_to :noticia, foreign_key: "titulo_noticia", primary_key: "titulo", class_name: "Noticia"
	belongs_to :categoria, foreign_key: "nombre_categoria", primary_key: "nombre", class_name: "Categoria"
end