class Admin::BrandsController < AdminController
    before_action :set_brand, only: [:show, :update, :destroy]


    def index
        @brands = Brand.all
        render json: {brands: @brands}
    end

    def create
        @brand = Brand.new(brand_params)
            if @brand.save
                render json: {success: true, brand: @brand.to_json}
            else
                render json: {success: false, errors: @brand.errors}
            end
    end

    def show
        render json: @brand.to_json
    end

    def update
        if @brand.update(brand_params)
            render json: {success: true, brand: @brand.to_json}
        else
            render json: {success: false, errors: @brand.errors}
        end
    end

    def destroy

    end

    private 

    def set_brand
        @brand = Brand.find(params[:id])
    end

    def brand_params
        params.require(:brand).permit(:title, image: [])
    end

    def parse_image_data(base64_image, filename)
        in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]
    
        @tempfile = Tempfile.new(filename)
        @tempfile.binmode
        @tempfile.write Base64.decode64(string)
        @tempfile.rewind
    
        # for security we want the actual content type, not just what was passed in
        content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]
    
        # we will also add the extension ourselves based on the above
        # if it's not gif/jpeg/png, it will fail the validation in the upload model
        # extension = content_type.match(/gif|jpeg|png/).to_s
        # filename += ".#{extension}" if extension
    
        ActionDispatch::Http::UploadedFile.new({
          tempfile: @tempfile,
          content_type: content_type,
          filename: filename
        })
      end

      # Only allow a trusted parameter "white list" through.
      def image_params
        the_params = params.require(:item_image).permit(:data_uri, :filename)
        parse_image_data(the_params[:data_uri],the_params[:filename]) if the_params[:filename]
      end

      def clean_tempfile
        if @tempfile
          @tempfile.close
          @tempfile.unlink
        end
      end

end
