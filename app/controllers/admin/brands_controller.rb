class Admin::BrandsController < AdminController
    before_action :set_brand, only: [:show, :update, :destroy]


    def index
        @brands = Brand.all
        @hash = {}
        @brands.each do |brand|
            @hash[brand.id] = brand
        end
        render json: {brands: @brands, list: @hash}
    end

    def create
        @brand = Brand.new(brand_params)
            if @brand.save
                render json: {success: true, brand: @brand}
            else
                render json: {success: false, errors: @brand.errors}
            end
    end

    def show
        render json: @brand.to_json
    end

    def update
        if @brand.update(brand_params)
            render json: {success: true, brand: @brand}
        else
            render json: {success: false, errors: @brand.errors}
        end
    end

    def destroy
        if @brand.destroy
            render json: {success: true}
        else
            render json: {success: false}
        end
    end

    private 

    def set_brand
        @brand = Brand.find(params[:id])
    end

    def brand_params
        the_params = params.require(:brand).permit(:title, :image => {})
        the_params[:image] = parse_image_data(the_params[:image][:data_uri],the_params[:image][:filename]) if the_params[:image] && the_params[:image][:base64]
        the_params
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

      def clean_tempfile
        if @tempfile
          @tempfile.close
          @tempfile.unlink
        end
      end

end
