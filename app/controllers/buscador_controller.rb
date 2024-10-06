class BuscadorController < ApplicationController


	def index

		@titulo = params[:titulo]

		if params[:titulo]==nil
			params[:titulo] = ""
		end

		noticias = Noticia.where("titulo LIKE ? ", "%"+params[:titulo]+"%").where(aprobado: true)
		
		@noticias_deseadas = []

		@categorias_seleccionadas = []

		first_iteration = true

		noticias.each do |noticia|
			i=0
			exist = false
			noShow = false
			bothSelected = 0
			
			esCritica = Critica.exists?(titulo_noticia: noticia.titulo)

			print(noticia.titulo+"\n")

			params.each do |param|
				
				relation = false 

				if param[1]=="on"
					if first_iteration
						@categorias_seleccionadas << param[0]
					end

					i = i+1
					relation = NotCat.exists?(titulo_noticia: noticia.titulo,nombre_categoria: param[0])
					
					if param[0] == "NOTICIAS"||param[0] == "CRITICAS"
						i = i-1
					end

					if params["NOTICIAS"]=="on" && esCritica
						noShow = true
						bothSelected = bothSelected +1
					elsif params["CRITICAS"]=="on" && !esCritica
						noShow = true
						bothSelected = bothSelected +1
					end


					print("\t"+noShow.to_s+" : "+esCritica.to_s+" : "+relation.to_s+"\n")

					if relation && !exist
						@noticias_deseadas << noticia
						exist = true
					end

					if noShow && exist
						@noticias_deseadas.pop()
						exist = false
					end

					

					
				end



			end

			first_iteration = false

			print("\t"+i.to_s+" : "+exist.to_s+"\n")

			if bothSelected==2
				noShow = false
			end

			if i==0 && !exist && !noShow
				@noticias_deseadas << noticia
			end
		end


		if @noticias_deseadas.length==0
			params.each do |param|
				if param[1]=="on"
					@categorias_seleccionadas << param[0]
				end
			end
		end


		@categorias = Categoria.all

	end

	
end
