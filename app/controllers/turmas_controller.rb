class TurmasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_turma, only: %i[show edit update destroy]

  def index
    @turmas = current_user.turmas.includes(alunos: { provas: { questoes: :gabarito } }).order(nome: :asc)
  end

  def show
    @alunos = @turma.alunos.includes(provas: { questoes: :gabarito }).order(nome: :asc)
  end

  def new
    @turma = current_user.turmas.new
  end

  def create
    @turma = current_user.turmas.new(turma_params)

    if @turma.save
      redirect_to turma_path(@turma), notice: "Turma criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @turma.update(turma_params)
      redirect_to turma_path(@turma), notice: "Turma atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @turma.destroy
    redirect_to turmas_path, notice: "Turma removida."
  end

  private

  def set_turma
    @turma = current_user.turmas.find(params[:id])
  end

  def turma_params
    params.require(:turma).permit(:nome)
  end
end
