#' Cria um Carrossel Shiny com Múltiplos Módulos
#'
#' @description
#' Esta função gera um carrossel customizado no Shiny.
#'
#' @param modules Lista de módulos UI (ex.: highchartOutput, plotOutput, etc.).
#' @param arrow_color Cor das setas de navegação (padrão = #000000).
#' @param indicator_color Cor dos indicadores inativos (padrão = #bbbbbb).
#' @param active_indicator_color Cor do indicador ativo (padrão = #333333).
#' @param indicator_labels Vetor de labels para cada slide (padrão = 1..n).
#' @param indicator_shape Formato dos indicadores: "circle" ou "square".
#' @param container_height Altura total do carrossel, em pixels (padrão = 400).
#'
#' @return UI do carrossel, pronto para uso em um app Shiny.
#' @export
#'
rcarousel <- function(
    modules,
    arrow_color = "#000000",
    indicator_color = "#bbbbbb",
    active_indicator_color = "#333333",
    indicator_labels = NULL,
    indicator_shape = c("circle", "square"),
    container_height = 400
) {
  # Garante que shiny esteja carregado
  requireNamespace("shiny", quietly = TRUE)

  # Valida o formato do indicador
  indicator_shape <- match.arg(indicator_shape)

  n_slides <- length(modules)
  # Se usuário não fornece labels, gera do 1..n
  if (is.null(indicator_labels)) {
    indicator_labels <- as.character(seq_len(n_slides))
  } else {
    # Se o usuário passou labels, verificamos se há mismatch
    if (length(indicator_labels) != n_slides) {
      stop(
        sprintf("The length of 'indicator_labels' [%d] must match the number of modules [%d].",
                length(indicator_labels), n_slides)
      )
    }
  }


  # Monta os slides dinamicamente
  slides <- lapply(seq_along(modules), function(i) {
    shiny::tags$div(class = "carousel-slide", modules[[i]])
  })

  # Monta os indicadores
  indicators <- lapply(seq_along(modules), function(i) {
    is_active <- if (i == 1) "active" else ""
    shape_class <- if (indicator_shape == "circle") "indicator-circle" else "indicator-square"

    shiny::tags$div(
      class = paste("carousel-indicator", shape_class, is_active),
      title = indicator_labels[i],
      onclick = sprintf("goToSlide(%d)", i - 1),
      # Só mostra o texto se for square
      if (indicator_shape == "square") indicator_labels[i]
    )
  })

  # Retorna o UI do Carrossel
  shiny::tagList(
    # Incluir o CSS e JS do pacote
    shiny::tags$head(
      # Aponta para "carousel.css" e "carousel.js" dentro do 'www' do pacote
      shiny::tags$link(rel = "stylesheet", type = "text/css", href = "meuCarousel/carousel.css"),
      shiny::tags$script(src = "meuCarousel/carousel.js"),

      # CSS inline para sobrescrever a altura do container
      shiny::tags$style(
        shiny::HTML(
          sprintf(".carousel-container { height: %dpx !important; }", container_height)
        )
      ),

      # Cores dinâmicas para setas e indicadores
      shiny::tags$style(shiny::HTML(sprintf("
        .carousel-btn { background-color: %s; }
        .carousel-indicator { background-color: %s; }
        .carousel-indicator.active { background-color: %s; }
      ",
                                            arrow_color, indicator_color, active_indicator_color
      )))
    ),

    # Estrutura principal do carrossel
    shiny::tags$div(
      class = "carousel-container",

      shiny::tags$div(
        class = "carousel-track",
        # Empacota todos os slides
        shiny::tagList(slides)
      ),

      # Botões de navegação
      shiny::actionButton("prev", "<<", class = "carousel-btn left", onclick = "prevSlide()"),
      shiny::actionButton("next", ">>", class = "carousel-btn right", onclick = "nextSlide()"),

      shiny::tags$div(
        class = "carousel-indicators_r",
        shiny::tagList(indicators)
      )
    )
  )
}

#' @importFrom shiny addResourcePath
.onLoad <- function(libname, pkgname) {
  # Adiciona o caminho estático 'meuCarousel/' => 'inst/www/'
  shiny::addResourcePath(
    "meuCarousel",
    system.file("www", package = pkgname)
  )
}
