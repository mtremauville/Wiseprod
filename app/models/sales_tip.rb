class SalesTip
  TIPS = {
    "smartphones" => "Proposez systématiquement la reprise de l'ancien appareil et une protection d'écran : ce sont les deux réflexes qui font grimper le panier moyen sur ce rayon.",
    "laptops" => "Insistez sur la garantie casse accidentelle, très recherchée pour un ordinateur transporté au quotidien entre le domicile, l'école ou le bureau.",
    "tablets" => "Présentez la tablette comme un compagnon multi-usage (famille, streaming, lecture) pour élargir la cible au-delà du seul usage professionnel."
  }.freeze

  def self.for(category)
    TIPS[category]
  end
end
