# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_todo
 before_action :set_todo_item, only: [:show, :update, :destroy]

  def index
    json_response(@todo.items)
  end

  def show
    json_response(@item)
  end

  def create
    @todo.items.create!(items_params)
    json_response(@todo, :created)
  end

  def update
    @item.update(items_params)
    head :no_content
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def items_params
    params.permit(:name, :done)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_todo_item
    @item = @todo.items.find_by!(id: params[:id]) if @todo
  end
end
