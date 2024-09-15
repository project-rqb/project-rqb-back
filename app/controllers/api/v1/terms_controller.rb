class Api::V1::TermsController < Api::V1::BasesController
  def index
    terms = Term.all.map(&:name)
    render json: terms, status: :ok
  end
end
