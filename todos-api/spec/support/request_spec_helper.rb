module ReuestSpecHelper
  def json
    JSON.parse(response.body)
  end
end