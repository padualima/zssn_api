class ActionDispatch::Routing::Mapper
  def draw(version)
    instance_eval(File.read(Rails.root.join("config/routes/#{version}.rb")))
  end
end
