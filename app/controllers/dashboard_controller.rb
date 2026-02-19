class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @provas_count = current_user.provas.count
    @questoes_count = current_user.provas.joins(:questoes).count
    @alunos_count = current_user.alunos.count
    @recent_provas = current_user.provas
                                 .includes(:aluno, :questoes)
                                 .order(created_at: :desc)
                                 .limit(5)
    @recent_alunos = current_user.alunos
                                 .order(created_at: :desc)
                                 .limit(5)
    @provas_this_month = current_user.provas
                                     .where(created_at: Time.current.beginning_of_month..)
                                     .count
  end
end
