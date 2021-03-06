class Api::V1::RecipesController < ApplicationController
  def index
    recipe = Recipe.all.order(created_at: :desc)
    render json: recipe
  end

  def show
    if recipe
      render json: recipe, status: :ok
    else
      render json: { message: 'Recipe not found!' }, status: :not_found
    end
  end

  def store
    recipe = Recipe.create!(recipe_params)
    if recipe
      render json: recipe, status: :ok
    else
      render json: { message: 'Recipe not found!' }, status: :not_found
    end
  end

  def destroy
    recipe&.destroy
    render json: { message: 'Recipe deleted!' }
  end

  private

  def recipe_params
    params.permit(:name, :image, :ingredients, :instruction)
  end

  def recipe
    begin
      @recipe ||= Recipe.find(params[:id])
    rescue ActiveRecord::RecordNotFound => exception
      nil
    end
  end
end
