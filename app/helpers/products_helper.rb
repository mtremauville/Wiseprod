module ProductsHelper
  def argument_points(text)
    text.to_s.split("\n")
      .map { |line| line.strip.sub(/\A(?:-|\*(?!\*)|•)\s+/, "").sub(/\A\d+[.)]\s*/, "") }
      .reject(&:blank?)
  end

  def format_argument_point(text)
    ERB::Util.html_escape(text).gsub(/\*\*(.+?)\*\*/) { "<strong>#{$1}</strong>" }.html_safe
  end
end
