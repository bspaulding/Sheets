def test_classes_for_collection(collection, &block)
  collection.each do |object|
    test_class = Class.new(Test::Unit::TestCase)
    Object.const_set("Test#{object.to_s.split(':')[-1]}Interface_#{Time.now.strftime('%Y%m%d%H%M%S%N')}", test_class)
    test_class.instance_exec(object, &block)
  end
end