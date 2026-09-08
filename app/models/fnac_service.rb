class FnacService
  SERVICES = {
    "vie_digitale_1" => {
      name: "Fnac Vie Digitale (Microsoft 365 + Antivirus) — 1 personne",
      categories: ["smartphones", "laptops", "tablets"]
    },
    "vie_digitale_5" => {
      name: "Fnac Vie Digitale (Microsoft 365 + Antivirus) — 5 personnes",
      categories: ["smartphones", "laptops", "tablets"]
    },
    "assurance_mensuelle" => {
      name: "Assurance mensualisée (engagement 1 an)",
      categories: ["smartphones", "laptops", "tablets"]
    },
    "garantie_reparation" => {
      name: "Garantie réparation",
      categories: ["smartphones"]
    },
    "garantie_echange_neuf" => {
      name: "Garantie échange à neuf (remboursement valeur d'achat, 4 ans)",
      categories: ["laptops", "tablets"]
    }
  }.freeze

  def self.available_for(category)
    SERVICES.values.select { |service| service[:categories].include?(category) }
  end
end
