class ApplicationController < ActionController::Base
    
    before_action :check_session

    def check_session

    if session[:usuario_id] != nil

      @usuario = Usuario.find_by(nickname: session[:usuario_id])

      session[:usuario_id] = @usuario.id
      session[:esAdmin] = nil
      session[:esSuperAdmin] = nil

      if Admin.exists?(nickname_admin: @usuario.id)

        admin = Admin.find_by(nickname_admin: @usuario.id)

        if admin.habilitado
          session[:esAdmin] = true
          session[:esSuperAdmin] = (admin.es_jefe) ? true : nil
        end


      end

      session[:esRedactor] = nil

      if Redactor.exists?(nickname_redactor: @usuario.id)

        redactor = Redactor.find_by(nickname_redactor: @usuario.id)

        if redactor.habilitado
          session[:esRedactor] = true
        end

      end

    end
  end
end