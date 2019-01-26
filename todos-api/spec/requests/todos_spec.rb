# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Todo API', type: :request do
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  describe 'GET /todos' do
    before { get '/todos' }
    it 'returns todo' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
    it 'return status code of 200' do
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context 'when the record exists' do
      it 'returns todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq todo_id
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the record does not exist' do
      let(:todo_id) { 100 }
      it 'returns status code  of 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end
  describe 'POST /todos' do
    let(:valid_attributies) { { title: 'Learn Elm', created_by: '1' } }
    context 'when the request is vaild' do
      before { post '/todos', params: valid_attributies }
      it 'creates a  todo' do
        expect(json['title']).to eq('Learn Elm') # params['title']
      end
      it 'returns status code 201 ' do
        expect(response).to have_http_status(201)
      end
    end
    context 'the request is invaild' do
      before { post '/todos', params: { title: 'Foobar' } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns validation failure message' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end
  describe 'PUT /todos/:id' do
    let(:valid_attributies) { { title: 'Shopping' } }
    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributies}
      it 'updates the record' do
        expect(response.body).to  be_empty
      end
      it 'retutns status code of 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}"}
    it 'returns status code of 2-4' do
      expect(response).to have_http_status(204)
    end
  end
end
