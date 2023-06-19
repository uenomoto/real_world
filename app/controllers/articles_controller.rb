class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_article, only: %i[show update destroy]
  def create
    @article = Article.new(article_params)

    if @article.save
      render_article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def show
    if @article
      render_article
    else
      render json: { error: 'slugに一致するArticleがデータベースにないよ!' }, status: :not_found
    end
  end

  def update
    @article.update(article_params)
    render_article
  end

  def destroy
    @article.destroy
    render_article
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end

  def set_article
    @article = Article.find_by(slug: params[:slug])
  end

  def render_article
    render json: { article: @article.to_json }
  end
end
