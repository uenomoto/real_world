class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @article = Article.new(article_params)

    if @article.save
      render_article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find_by(slug: params[:slug])
    if @article
      render_article
    else
      render json: { error: 'slugに一致するArticleがデータベースにないよ!' }, status: :not_found
    end
  end

  def update
    @article = Article.find_by(slug: params[:slug])
    @article.update(article_params)
    render_article
  end

  def destroy
    @article = Article.find_by(slug: params[:slug])
    @article.destroy
    render_article
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end

  def render_article
    render json: { article: @article.to_json }
  end
end
