class NoticiaController < ApplicationController

	def index
		@titulo = params.extract_value(:titulo)[0].gsub!(" ","%20")


		@noticia = Noticia.find(params.extract_value(:titulo))
		@comentarios = Comentario.where(titulo_noticia: @noticia.titulo)
		@valoraciones = nil

		if Critica.exists?(titulo_noticia: @noticia.titulo)
			@valoraciones = Valoracion.where(titulo_noticia: @noticia.titulo)
		end

		@notaRedactores = 0
		@notaUsuarios = 0

		nRedactores = 0
		nUsuarios = 0

		if @valoraciones != nil

			@valoraciones.each do |valoracion|

				if Redactor.exists?(nickname_redactor: valoracion.nickname_usuario)

					r = Redactor.find_by(nickname_redactor: valoracion.nickname_usuario)

					if r.habilitado
						@notaRedactores = @notaRedactores + valoracion.nota
						nRedactores = nRedactores+1
					else
						@notaUsuarios = @notaUsuarios + valoracion.nota
						nUsuarios = nUsuarios+1
					end
				else

					@notaUsuarios = @notaUsuarios + valoracion.nota
					nUsuarios = nUsuarios+1

				end

			end

		end 

		@notaRedactores = nRedactores != 0 ? (@notaRedactores.to_f/nRedactores).round(1): "-"
		@notaUsuarios = nUsuarios != 0 ? (@notaUsuarios.to_f/nUsuarios).round(1) : "-"


		rescue ActiveRecord::RecordNotFound
  		redirect_to '/error'
	end

	def redactar_noticia

	end

	def upload_new

		if session[:usuario_id]==nil
			redirect_to '/error', notice: 'Necesitas estar logueado para esta accion'
			return
		end

		@noticia = Noticia.new

		ultima_noticia = Noticia.last

		n = Dir[Rails.root.join('public','uploads','noticias','*')].length+1

		print(params[:title] + ":" + params[:content] + "\n")

		if params[:title].present? && params[:content].present? && params[:image]!=nil

			image_path = Rails.root.join('public','uploads','noticias',"image#{n}#{File.extname(params[:image].original_filename)}")


			@noticia.titulo = params[:title].parameterize.upcase.gsub('-',' ')
			@noticia.contenido = params[:content]

			@noticia.enlace_imagen = "image#{n}#{File.extname(params[:image].original_filename)}"

			@noticia.aprobado = false
			@noticia.fecha_publicacion = Date.current

			#Faltan asignar el campo de nickname_redactor, que para ello necesito que el sistema de login este hecho
			@noticia.nickname_redactor = session[:usuario_id][0]
			
			if !(Noticia.exists?(titulo: @noticia.titulo)) && @noticia.save

				File.open(image_path,'wb') do |file|

					file.write(params[:image].read)
	
				end

				if params[:type]=="critica"
					@critica = Critica.new
					@critica.titulo_noticia = @noticia.titulo
					@critica.save!
				end

				redirect_to '/', notice: 'Noticia guardada'
			else
				redirect_to '/noticia/redactar', notice: 'Error guardando'
			end

			return
		end

		redirect_to '/noticia/redactar', notice: 'Campos incompletos'
	end
	
end
