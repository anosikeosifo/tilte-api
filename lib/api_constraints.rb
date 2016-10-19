class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end


  def matches?(reqst)
    #if no request param is specified, use the default
    @default || reqst.headers['Accept'].include?("application/vnd.tilte-api.v#{@version}")
  end
end