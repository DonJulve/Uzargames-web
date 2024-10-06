class Reporte < ApplicationRecord
	self.table_name = "zargames.REPORTES"
	self.primary_key = [:id_comentario,:nickname_usuario]

	belongs_to :usuario, foreign_key: "nickname_usuario", primary_key: "nickname", class_name: "Usuario"
	belongs_to :comentario, foreign_key: "id_comentario", primary_key: "id_comentario", class_name: "Comentario"
end