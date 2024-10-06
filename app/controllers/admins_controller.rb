class AdminsController < ApplicationController
	layout "admin"

	def index
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end
	end

    ##############
	# REDACTORES #
	##############

	def redactores
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end

		@usuarios = Usuario.where.not(
			nickname: Redactor.select(:nickname_redactor)
		).or(Usuario.where(
			nickname: Redactor.select(:nickname_redactor).where(habilitado: false)
		)).or(Usuario.where(
			nickname: Redactor.select(:nickname_redactor).where(habilitado: nil)
		))

		@redactores = Redactor.where(habilitado: true)



		#redactores.each do |redactor|

		#	@usuarios.remove(redactor)

		# end


	end

	def redactores_add
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end

		nickname = params[:nickname]

		usuario = Usuario.find_by(nickname: nickname)

		if usuario == nil
			redirect_to '/error', notice: 'No existe el usuario'
			return
		end

		if !Redactor.exists?(nickname_redactor: usuario.nickname)

			redactor = Redactor.new
			redactor.nickname_redactor = usuario.nickname
			redactor.habilitado = true

			redactor.save


			redirect_to '/admin/redactores'
			return
		end

		redactor = Redactor.find_by(nickname_redactor: usuario.nickname)

		if !redactor.habilitado

			redactor.habilitado = true
			redactor.save

			redirect_to '/admin/redactores'
			return
		end

		redirect_to '/error', notice: 'Ya es un redactor'
		
	end

	def redactores_remove
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end

		nickname = params[:nickname]

		usuario = Usuario.find_by(nickname: nickname)

		if usuario == nil
			redirect_to '/error', notice: 'No existe el usuario'
			return
		end

		if Redactor.exists?(nickname_redactor: usuario.nickname)

			redactor = Redactor.find_by(nickname_redactor: usuario.nickname)

			if redactor.habilitado

				redactor.habilitado = false
				redactor.save

				redirect_to '/admin/redactores'
				return
			end
		end

		

		redirect_to '/error', notice: 'No es un redactor'
		
	end

	############
	# REPORTES #
	############

	def reportes
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end
	end

	############
	# NOTICIAS #
	############

	def noticias
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end

		@noticias_no_aprobadas = Noticia.where.not(
		  titulo: Critica.select(:titulo_noticia)
		).where(aprobado: false)
		
		@noticias_aprobadas = Noticia.where.not(
		  titulo: Critica.select(:titulo_noticia)
		).where(aprobado: true)

	end

	def noticias_add
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end

		titulo = params[:titulo]

		noticia = Noticia.find_by(titulo: titulo)

		if noticia == nil
			redirect_to '/error', notice: 'No existe la noticia'
			return
		end

		if !Critica.exists?(titulo_noticia: noticia.titulo)

			noticia.aprobado = true
			noticia.save
			


			redirect_to '/admin/noticias'
			return
		end

		redirect_to '/error', notice: 'No existe la noticia'

	end

	def noticias_remove
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end

		titulo = params[:titulo]

		noticia = Noticia.find_by(titulo: titulo)

		if noticia == nil
			redirect_to '/error', notice: 'No existe la noticia'
			return
		end

		if !Critica.exists?(titulo_noticia: noticia.titulo)

			noticia.aprobado = false
			noticia.save
			


			redirect_to '/admin/noticias'
			return
		end

		redirect_to '/error', notice: 'No existe la noticia'

	end

	############
	# CRITICAS #
	############

	def criticas
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end

		@criticas_no_aprobadas = Noticia.where(
		  titulo: Critica.select(:titulo_noticia)
		).where(aprobado: false)
		
		@criticas_aprobadas = Noticia.where(
		  titulo: Critica.select(:titulo_noticia)
		).where(aprobado: true)

	end

	def criticas_add
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end

		titulo = params[:titulo]

		noticia = Noticia.find_by(titulo: titulo)

		if noticia == nil
			redirect_to '/error', notice: 'No existe la critica'
			return
		end

		if Critica.exists?(titulo_noticia: noticia.titulo)

			noticia.aprobado = true
			noticia.save
			


			redirect_to '/admin/criticas'
			return
		end

		redirect_to '/error', notice: 'No existe la critica'

	end

	def criticas_remove
		if session[:esAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser administrador para esta accion'
			return
		end

		titulo = params[:titulo]

		noticia = Noticia.find_by(titulo: titulo)

		if noticia == nil
			redirect_to '/error', notice: 'No existe la critica'
			return
		end

		if Critica.exists?(titulo_noticia: noticia.titulo)

			noticia.aprobado = false
			noticia.save
			


			redirect_to '/admin/criticas'
			return
		end

		redirect_to '/error', notice: 'No existe la critica'

	end

	###################
	# ADMINISTRADORES #
	###################

	def admins
		if session[:esSuperAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser super administrador para esta accion'
			return
		end

		@usuarios = Usuario.where.not(
			nickname: Admin.select(:nickname_admin)
		).or(Usuario.where(
			nickname: Admin.select(:nickname_admin).where(habilitado: false)
		)).or(Usuario.where(
			nickname: Admin.select(:nickname_admin).where(habilitado: nil)
		))

		@admins = Admin.where(habilitado: true)
	end

	def admins_add
		if session[:esSuperAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser super administrador para esta accion'
			return
		end

		nickname = params[:nickname]

		usuario = Usuario.find_by(nickname: nickname)

		if usuario == nil
			redirect_to '/error', notice: 'No existe el usuario'
			return
		end

		if !Admin.exists?(nickname_admin: usuario.nickname)

			admin = Admin.new
			admin.nickname_admin = usuario.nickname
			admin.habilitado = true

			admin.save


			redirect_to '/admin/admins'
			return
		end

		admin = Admin.find_by(nickname_admin: usuario.nickname)

		if !admin.habilitado

			admin.habilitado = true
			admin.save

			redirect_to '/admin/admins'
			return
		end

		redirect_to '/error', notice: 'Ya es un administrador'
		
	end

	def admins_remove
		if session[:esSuperAdmin]==nil
			redirect_to '/error', notice: 'Necesitas ser super administrador para esta accion'
			return
		end

		nickname = params[:nickname]

		usuario = Usuario.find_by(nickname: nickname)

		if usuario == nil
			redirect_to '/error', notice: 'No existe el usuario'
			return
		end

		if Admin.exists?(nickname_admin: usuario.nickname)

			admin = Admin.find_by(nickname_admin: usuario.nickname)

			if admin.habilitado

				admin.habilitado = false
				admin.save

				redirect_to '/admin/admins'
				return
			end
		end

		

		redirect_to '/error', notice: 'No es un administrador'
		
	end
end
