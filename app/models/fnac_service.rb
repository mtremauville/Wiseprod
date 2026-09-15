class FnacService
  SERVICES = {
    "vie_digitale_1" => {
      name: "Fnac Vie Digitale (Microsoft 365 + Antivirus) — 1 personne",
      sku: "9000001",
      categories: ["smartphones", "laptops", "tablets"]
    },
    "vie_digitale_5" => {
      name: "Fnac Vie Digitale (Microsoft 365 + Antivirus) — 5 personnes",
      sku: "9000002",
      categories: ["smartphones", "laptops", "tablets"]
    },
    "assurance_mensuelle" => {
      name: "Assurance mensualisée (engagement 1 an)",
      sku: "9000003",
      categories: ["smartphones", "laptops", "tablets"]
    },
    "garantie_reparation" => {
      name: "Garantie réparation",
      sku: "9000004",
      categories: ["smartphones"]
    },
    "garantie_echange_neuf" => {
      name: "Garantie échange à neuf (remboursement valeur d'achat, 4 ans)",
      sku: "9000005",
      categories: ["laptops", "tablets"]
    }
  }.freeze

  def self.available_for(category)
    SERVICES.select { |_key, service| service[:categories].include?(category) }
            .map { |key, service| service.merge(key: key) }
  end

  def self.names_for(keys)
    Array(keys).map { |key| SERVICES.dig(key, :name) }.compact
  end

  def self.by_key(key)
    SERVICES[key]
  end
end
