class SalesArgumentGenerator
  def initialize(product, selected_services, consultation = nil)
    @product = product
    @selected_services = selected_services
    @consultation = consultation
  end

  def call
    services_text = @selected_services.any? ? @selected_services.join(", ") : "aucun service additionnel"

    context_text = if @consultation
      <<~CONTEXT
        Profil du client :
        - Usage recherché : #{@consultation.usage_type}
        - Budget : #{@consultation.budget_range}
        - Priorité : #{@consultation.priority}
      CONTEXT
    else
      ""
    end

    prompt = <<~PROMPT
      Tu es un conseiller de vente Fnac spécialisé en high-tech.
      Produit : #{@product.name} (#{@product.category})
      Description : #{@product.description}
      Prix : #{@product.price} €

      #{context_text}

      Services additionnels à proposer avec ce produit : #{services_text}

      Rédige un argumentaire de vente convaincant qui répond spécifiquement au besoin exprimé par le client
      (pas un argumentaire générique), met en avant les points forts du produit en lien avec sa priorité,
      puis enchaîne sur les services additionnels listés.
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
