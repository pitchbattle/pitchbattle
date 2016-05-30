require 'rails_helper'

describe StaticController do

  describe '#home' do
    before { get :home }

    it { should respond_with :ok }
  end

end
