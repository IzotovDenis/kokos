#encoding: utf-8

require 'spec_helper'
RSpec.describe Admin::ItemsController, type: :controller do
    before(:all) do
    end

    before(:each) do

    end

    it 'should no item' do
        get :show, params: { id: 1 }
        expect(response.status).to eq(404)
    end

    it 'correct create item' do
        
    end

end

