# coding: utf-8
class PublicationsController < ApplicationController
  def index
    @publications = Publication.order('created_at desc').page(params[:page]).per(10)
  end

  def show
    @publication = Publication.find params[:id]
    @skilltag = Skilltag.new
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new params[:publication]
    @publication.users << current_user

    if @publication.save
      redirect_to @publication, notice: "#{@publication.title}を登録しました"
    else
      render 'new'
    end
  end

  def add_author
    @publication = Publication.find params[:id]

    if @publication.users << current_user
      redirect_to @publication, notice: "#{@publication.title}の著者にあなたを追加しました"
    else
      redirect_to @publication, notice: "#{@publication.title}の著者にあなたを追加できませんでした。"
    end
  end

  def add_skilltag
    @publication = Publication.find params[:id]
    @skilltag = Skilltag.find_by_name(params[:skilltag][:name]) || Skilltag.new(params[:skilltag])

    if @publication.skilltags << @skilltag
      redirect_to @publication, notice: "#{@publication.title}のスキルに#{@skilltag.name}を追加しました"
    else
      redirect_to @publication, notice: "#{@publication.title}のスキルに#{@skilltag.name}を追加できませんでした"
    end
  end
end
