class SesionController < ApplicationController
  layout "sesion"

  def index
    
  end

  def new
    @usuario = Usuario.new
  end
  
  def register
    @usuario = Usuario.new(usuario_params)
    @usuario.bloqueado = false
    @usuario.verificado = false
    
    
    if @usuario.save
      session[:usuario_id] = @usuario.id
      redirect_to '/', notice: 'Usuario registrado con éxito.'
    else
      flash[:alert] = @usuario.errors.full_messages.join(', ')
      redirect_to '/login'
    end
  end
  
  

  def self.hash_string(input_string)
    require 'digest'
    # Create a new SHA-256 hash object
    sha256 = Digest::SHA256.new

    # Update the hash object with the input string
    sha256.update(input_string)

    # Get the hexadecimal representation of the hash
    hashed_string = sha256.hexdigest

    puts(hashed_string)
    puts('hashed_string')

    return hashed_string
  end


  def login
    @usuario = Usuario.find_by(nickname: params[:session][:nickname])

    password = SesionController.hash_string(params[:session][:password])

    if @usuario && (@usuario.contraseña) == password
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

      redirect_to '/', notice: 'Inicio de sesión exitoso.'
    else
      flash[:alert] = 'Credenciales inválidas.'
      redirect_to '/login'
    end
  end

  def logout
    session[:usuario_id] = nil
    session[:esAdmin] = nil
    session[:esSuperAdmin] = false
    session[:esRedactor] = nil
    redirect_to '/', notice: 'Cierre de sesión exitoso.'
  end

  private
  
  def usuario_params
    params.require(:usuario).permit(:correo, :nickname, :contraseña)
  end  
end