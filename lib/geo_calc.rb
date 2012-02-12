class GeoCalc
  def cartesian_center(array)
    results = []
    array.each do |coordinates|
      coordinates.each_with_index do |coordinate, index|
        results[index] = 0 if results[index].nil?
        results[index] += coordinate
      end
    end
    results.collect { |coordinate| coordinate/array.length }
  end
  
  
  def bounds_center(array)
    latitude = { :min => nil, :max => nil }
    longitude = { :min => nil, :max => nil }
    
    array.each do |coordinate|
      latitude[:min] = coordinate[0] if latitude[:min].nil? || latitude[:min] > coordinate[0]
      latitude[:max] = coordinate[0] if latitude[:max].nil? || latitude[:max] < coordinate[0]
      longitude[:min] = coordinate[1] if longitude[:min].nil? || longitude[:min] > coordinate[1]
      longitude[:max] = coordinate[1] if longitude[:max].nil? || longitude[:max] < coordinate[1]
    end
    
    [ (latitude[:max] + latitude[:min]) / 2, (longitude[:max] + longitude[:min]) / 2 ]
  end
  
  
  def vector_center(array)
    vector = [0,0,0]
    array.each do |coordinate|
      x = coordinate[0] * Math::PI / 180
      y = coordinate[1] * Math::PI / 180
  
      vector[0] += Math.cos(x) * Math.cos(y)
      vector[1] += Math.cos(x) * Math.sin(y)
      vector[2] += Math.sin(x)
    end
    
    vector = normalize_vector(vector)
    
    x = Math.atan2(vector[2], Math.sqrt(vector[0]**2 + vector[1]**2))
    y = Math.atan2(vector[1], vector[0])
    [x*180/Math::PI,y*180/Math::PI]
  end
  
  def vector_length(vector)
    Math.sqrt(vector[0]**2 + vector[1]**2 + vector[2]*2)
  end
  
  def normalize_vector(vector)
    length = vector_length(vector)
    vector.collect { |member| member/length}
  end
end