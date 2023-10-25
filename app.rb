require 'rack'
require 'json'
require 'thread'
require 'jwt'
require 'dotenv/load'


class MiApp
  SECRET_KEY = ENV['SECRET_KEY'] || 'clave_secundaria'

  USERS = {
    'user1' => 'password1',
    'user2' => 'password2'
  }

  def initialize
    @products = load_products
    @mutex = Mutex.new
    @next_product_id = @products.empty? ? 1 : @products.max_by { |product| product['id'] }['id'].to_i + 1

  end
  

  def call(env)
    request = Rack::Request.new(env)
    headers = {
      'Content-Type' => 'application/json',
    }

    case request.path

  when "/auth"
    if request.post?
      user_data = JSON.parse(request.body.read)
      username = user_data['user']
      password = user_data['password']

      if USERS[username] == password
        token = generate_token(username)
        [200, headers, [token]]
      else
        [401, headers, ["Error de autenticación"]]
      end
    end

    when "/products"
      # Verificar la autenticación con JWT
      auth_header = request.env['HTTP_AUTHORIZATION']
      if !auth_header || !valid_token?(auth_header)
        return [401, headers, ["No autorizado"]]
      end
      if request.get?
        response = {
          products: @products
        }
        json_response = JSON.generate(response)
        
        [200, headers, [json_response]]    
    end

    when "/add_product"
      # Verificar la autenticación con JWT
      auth_header = request.env['HTTP_AUTHORIZATION']
      if !auth_header || !valid_token?(auth_header)
        return [401, headers, ["No autorizado"]]
      end
      if request.post?
        new_product = JSON.parse(request.body.read)
        puts @next_product_id  

        new_product['id'] = @next_product_id        

        Thread.new do
          sleep 5
          @mutex.synchronize do
            @products << new_product
            save_products(@products) # Guardar los products en el archivo JSON
          end
        end

        [200, headers, ["Creando el producto de forma asíncrona"]]
      end
    else
      [404, headers, ["Ruta no encontrada"]]
    end
  end

  def load_products
    if File.exist?('products.json')
      products_data = File.read('products.json')
      JSON.parse(products_data)
    else
      []
    end
  end

  def save_products(products)
    File.open('products.json', 'w') do |file|
      file.write(JSON.pretty_generate(products))
    end
  end


  private

  def generate_token(username)
    payload = { username: username }
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def valid_token?(auth_header)
    token = auth_header.split(' ').last
    begin
      decoded_token = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
      return true
    rescue JWT::DecodeError
      return false
    end
  end
  

end

Rack::Handler::Thin.run MiApp.new, Port: 5000
