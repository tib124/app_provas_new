# frozen_string_literal: true

class Turma < ApplicationRecord
  belongs_to :usuario, class_name: "User", inverse_of: :turmas
  has_many :alunos, dependent: :nullify, inverse_of: :turma

  validates :nome, presence: true
  validates :nome, uniqueness: { scope: :usuario_id, case_sensitive: false, message: "já existe uma turma com este nome" }
end
