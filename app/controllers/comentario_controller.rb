class ComentarioController < ApplicationController
	

	def addComent
		require 'date'

		if session[:usuario_id]==nil
			redirect_to '/error', notice: 'Necesitas estar logueado para esta accion'
			return
		end

		#@noticia = Noticia.find(params.extract_value(:titulo))


		#@usuario = Usuario.find(params.extract_value(:id_usuario))

		@comentario = Comentario.new

		if Comentario.count == 0
			@comentario.id_comentario = 0
		else
			@comentario.id_comentario = Comentario.last.id_comentario.to_i+1
		end

		
		@comentario.nickname_usuario = params.extract_value(:id_usuario)[0]
		@comentario.contenido = params[:comentario].to_s
		@comentario.titulo_noticia = params.extract_value(:titulo)[0]
		@comentario.fecha = Date.current

		print(@comentario.id_comentario.to_s+"\n")
		print(@comentario.nickname_usuario+"\n")
		print(@comentario.contenido+"\n")
		print(@comentario.titulo_noticia+"\n")
		print(@comentario.fecha.to_s+"\n")

		if @comentario.save!
			redirect_to '/', notice: 'Comentario posteado con exito'
		else
			redirect_to '/error', notice: 'Error posteando el comentario'
		end
	end

end