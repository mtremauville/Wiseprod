class SavResponseGenerator
  def initialize(product, situation)
    @product = product
    @situation = situation
  end

  def call
    prompt = <<~PROMPT
      Tu es un conseiller vente d'un magasin high-tech.
      Produit concerné : #{@product.name} (#{@product.category})
      Description : #{@product.description}
      Situation client : #{@situation}

      Rédige une réponse SAV professionnelle, empathique et claire, adaptée à cette situation.
    PROMPT

    begin
      response = RubyLLM.chat.ask(prompt)
      response.content
    rescue => e
      Rails.logger.error("Erreur génération IA: #{e.message}")
      "Une erreur est survenue lors de la génération. Réessaie dans quelques instants."
    end
  end
end
