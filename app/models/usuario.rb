class Usuario < ApplicationRecord
	self.table_name = "zargames.USUARIO"
	self.primary_key = [:nickname]
    
	validates :nickname, presence: { message: "no puede estar en blanco" }, uniqueness: { case_sensitive: false, message: "elegido ya está en uso" }
	validates :correo, presence: { message: "no puede estar en blanco" }
	validates :contraseña, presence: { message: "no puede estar en blanco" }
  
	validate :validate_presence_of_fields
	validate :validate_email_format
	before_save :hash_password, if: -> { contraseña.present? }
	validate :validate_contraseña_format
  
	def validate_presence_of_fields
	  if correo.blank? || nickname.blank? || contraseña.blank?
		errors.add(:base, "Todos los campos son obligatorios")
	  end
	end
  
	def validate_email_format
	  if !(correo =~ /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/) && !correo.blank?
		errors.add(:correo, "con formato inválido")
	  end
	end
  
	def validate_contraseña_format
	  if !contraseña.blank?
		unless contraseña.length >= 8
		  errors.add(:contraseña, "debe tener al menos 8 caracteres")
		end
  
		unless /[a-z]/.match?(contraseña)
		  errors.add(:contraseña, "debe contener al menos una letra minúscula")
		end
  
		unless /[A-Z]/.match?(contraseña)
		  errors.add(:contraseña, "debe contener al menos una letra mayúscula")
		end
  
		unless /\d/.match?(contraseña)
		  errors.add(:contraseña, "debe contener al menos un dígito")
		end
	  end
	end

	def hash_password
		self.contraseña = SesionController.hash_string(contraseña)
	end
end
  