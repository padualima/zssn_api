class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || (req.headers['Accept'] && req.headers['Accept'].include?("application/vnd.zssn.v#{@version}"))
  end
end
