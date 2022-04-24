module EnvironmentHelper
  def api_headers(version: 1)
    {
      'Accept' => "application/vnd.zssn.v#{version}"
    }
  end
end
