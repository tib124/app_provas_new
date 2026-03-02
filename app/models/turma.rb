# frozen_string_literal: true

class Turma < ApplicationRecord
  belongs_to :usuario, class_name: "User", inverse_of: :turmas
  has_many :alunos, dependent: :nullify, inverse_of: :turma

  validates :nome, presence: true
  validates :nome, uniqueness: { scope: :usuario_id, case_sensitive: false, message: "já existe uma turma com este nome" }
  validates :slug, uniqueness: true, allow_nil: true

  before_create :generate_slug

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = nome.to_s.parameterize.presence || SecureRandom.hex(6)
    base = slug
    counter = 2
    while Turma.exists?(slug: slug)
      self.slug = "#{base}-#{counter}"
      counter += 1
    end
  end
end
