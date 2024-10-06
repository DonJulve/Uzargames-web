class ValoracionController < ApplicationController
	

	def addReview
		require 'date'
		#@noticia = Noticia.find(params.extract_value(:titulo))


		#@usuario = Usuario.find(params.extract_value(:id_usuario))

		if session[:usuario_id]==nil
			redirect_to '/error', notice: 'Necesitas estar logueado para esta accion'
			return
		end


		@valoracion = Valoracion.new



		@valoracion.titulo_noticia = params.extract_value(:titulo)[0]
		@valoracion.nickname_usuario = params.extract_value(:id_usuario)[0]


		if params[:nota].to_i.between?(0,10)
			@valoracion.nota = params[:nota].to_i
		else
			redirect_to '/error', notice: 'Error posteando la valoracion'
			return
		end

		
		if !params[:puntos_positivos].to_s.empty?
			@valoracion.puntos_positivos = params[:puntos_positivos].to_s
		else
			redirect_to '/error', notice: 'Error posteando la valoracion'
			return
		end

		if !params[:puntos_negativos].to_s.empty?
			@valoracion.puntos_negativos = params[:puntos_negativos].to_s
		else
			redirect_to '/error', notice: 'Error posteando la valoracion'
			return
		end


		if Valoracion.exists?(titulo_noticia: @valoracion.titulo_noticia,
			nickname_usuario: @valoracion.nickname_usuario)

			Valoracion.find([@valoracion.titulo_noticia, @valoracion.nickname_usuario]).delete
		end
		


		if @valoracion.save!
			redirect_to '/', notice: 'Valoracion posteada con exito'
		else
			redirect_to '/error', notice: 'Error posteando la valoracion'
		end
	end

end