class SalesArgumentGenerator
  def initialize(product, services)
    @product = product
    @services = services
  end

  def call
    prompt = <<~PROMPT
      Tu es un conseiller de vente Fnac spécialisé en high-tech.
      Produit : #{@product.name} (#{@product.category})
      Description : #{@product.description}
      Prix : #{@product.price} €

      Services additionnels à proposer avec ce produit : #{services_text}

      Rédige un argumentaire de vente convaincant pour ce produit, qui met en avant ses points forts,
      puis enchaîne naturellement sur la proposition des services additionnels listés,
      en expliquant leur intérêt pour le client de façon concise et persuasive.
    PROMPT

    begin
      response = RubyLLM.chat.ask(prompt)
      response.content
    rescue => e
      Rails.logger.error("Erreur génération IA: #{e.message}")
      "Une erreur est survenue lors de la génération. Réessaie dans quelques instants."
    end
  end

  private

  def services_text
    @services.any? ? @services.join(", ") : "aucun"
  end
end
