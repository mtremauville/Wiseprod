class SalesArgumentGenerator
  def initialize(product)
    @product = product
  end

  def call
    prompt = <<~PROMPT
      Tu es un conseiller de vente Fnac spécialisé en high-tech.
      Produit : #{@product.name} (#{@product.category})
      Description : #{@product.description}
      Prix : #{@product.price} €

      Rédige la liste des points forts de ce produit sous forme de liste à puces convaincante (5 à 7 points maximum).
      Chaque point doit être une phrase courte et percutante, mettant en avant un point fort du produit.
      Dans chaque point, entoure de ** ** les 1 ou 2 mots-clés les plus importants (ex: "**Autonomie** de 20h").
      Réponds uniquement avec la liste, une puce par ligne commençant par "- ", sans introduction ni conclusion.
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
