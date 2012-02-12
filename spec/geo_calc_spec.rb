require 'spec_helper'

describe GeoCalc do
  let(:geo_calc) { GeoCalc.new}
  
  describe '#cartesian_center' do
    context 'y are zero' do
      it 'returns center of cartesian coordinates' do
        a = [1,0]
        b = [3,0]
        geo_calc.cartesian_center([a,b]).should == [2,0]
      end
    end
    
    context 'x are zero' do
      it 'returns center of cartesian coordinates' do
        a = [0,5]
        b = [0,9]
        geo_calc.cartesian_center([a,b]).should == [0,7]
      end
    end
    
    it 'works with arrays of multiple lengths' do
      a = [0,5,2]
      b = [0,9,4]
      geo_calc.cartesian_center([a,b]).should == [0,7,3]
    end
  end
  
  describe '#vector_center' do
    context 'y are zero' do
      it 'returns center of cartesian coordinates' do
        a = [1,0]
        b = [3,0]
        result = geo_calc.vector_center([a,b])
        [result[0].round, result[1].round].should == [2,0]
      end
    end
    
    context 'x are zero' do
      it 'returns center of cartesian coordinates' do
        a = [0,5]
        b = [0,9]
        result = geo_calc.vector_center([a,b])
        [result[0].round, result[1].round].should == [0,7]
        
      end
    end
  end
  
  describe '#bounds_center' do
    it "returns the average of max and min latitude and longitude" do
      a = [10, 2]
      b = [3, 8]
      c = [-2, 2]
      geo_calc.bounds_center([a,b,c]).should == [4, 5]
    end
  end
end