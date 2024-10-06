class IndexController < ApplicationController
	before_action :set_noticias_and_criticas, only: [:index]
	
  
	def index
		respond_to do |format|
		  format.html
		  format.js { render inline: "inicializarPagina();" }
		end
	end
  
	private
  
	def set_noticias_and_criticas
		@noticias = Noticia.where(aprobado: true)
				.where.not(titulo: Critica.pluck(:titulo_noticia))
				.order(fecha_publicacion: :desc)
				.limit(5)
		@criticas = Noticia.where(aprobado: true, titulo: Critica.pluck(:titulo_noticia))
                   .order(fecha_publicacion: :desc)
                   .limit(5)

		titulos_criticas = @criticas.pluck(:titulo)
		@valoraciones = Valoracion.where(titulo_noticia: titulos_criticas)
		@notas_por_critica = {}

		@criticas.each do |critica|
		  titulos_criticas = [critica.titulo]
		  valoraciones = Valoracion.where(titulo_noticia: titulos_criticas)
	
		  notaRedactores = 0
		  notaUsuarios = 0
		  nRedactores = 0
		  nUsuarios = 0
	
		  valoraciones.each do |valoracion|
			if Redactor.exists?(nickname_redactor: valoracion.nickname_usuario)
				r = Redactor.find_by(nickname_redactor: valoracion.nickname_usuario)

				if r.habilitado
			  		notaRedactores += valoracion.nota
			  		nRedactores += 1
		  		else
		  			notaUsuarios += valoracion.nota
			  		nUsuarios += 1
	  			end
			else
			  notaUsuarios += valoracion.nota
			  nUsuarios += 1
			end
		  end
	
		  notaRedactores = nRedactores != 0 ? (notaRedactores.to_f / nRedactores).round(1) : "-"
		  notaUsuarios = nUsuarios != 0 ? (notaUsuarios.to_f / nUsuarios).round(1) : "-"
	
		  @notas_por_critica[critica.titulo] = { notaRedactores: notaRedactores, notaUsuarios: notaUsuarios }
		end
	end
end