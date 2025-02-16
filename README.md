# rcarousel <img src="https://img.shields.io/badge/version-0.1.0-blue.svg" align="right" />

> **An interactive, track-based carousel for Shiny applications**.

`rcarousel` is an R package that provides a fully customizable, responsive carousel component for [Shiny](https://shiny.rstudio.com) apps. It allows you to cycle through any number of UI modules—like highcharts, tables, or images—within a horizontal slider. 

<div align="center">
  <!-- Replace this with an actual screenshot or GIF of your carousel in action -->
  <img src="docs/images/carousel_demo.png" alt="rcarousel demo" width="600">
</div>

## Features

- **Easy to use**: Simply pass a list of Shiny UI modules to the function and let `rcarousel` handle the rest.
- **Customizable indicators**: Choose between circle dots or square buttons with labels to navigate slides.
- **Color customization**: Define custom colors for the arrow buttons, indicator states, and more.
- **Adjustable height**: Control the container height to ensure your content and indicators are perfectly visible.
- **Responsive design**: Built on a track-based layout, slides scale horizontally for a smooth user experience.

## Installation

You can install the development version from [GitHub](https://github.com/robsondonato/rcarousel/rcarousel/) using:

```r
# install.packages("devtools")
devtools::install_github("robsondonato/rcarousel/rcarousel/")
```

## Installing rcarousel Locally

If you have downloaded the `.tar.gz` file from the GitHub releases or built it yourself, you can install `rcarousel` locally in R using the following steps.

### **1. Download the `.tar.gz` file**
You can download the latest `.tar.gz` package from the **[Releases](https://github.com/robsondonato/rcarousel/)** section of the GitHub repository.

Alternatively, if you have built the package locally using `R CMD build`, the `.tar.gz` file should be available in your working directory.

### **2. Install the package locally**
Once you have the `.tar.gz` file, open R and run:

```r
install.packages("path/to/rcarousel_0.1.0.tar.gz", repos = NULL, type = "source")
```

Replace `"path/to/rcarousel_0.1.0.tar.gz"` with the **actual path** where the file is located.

## Getting Started

Here’s a minimal Shiny example that demonstrates how to use `rcarousel`:

```r
library(shiny)
library(highcharter)
library(rcarousel)

ui <- fluidPage(
  rcarousel(
    modules = list(
      highchartOutput("plot1", height = "300px"),
      highchartOutput("plot2", height = "300px"),
      highchartOutput("plot3", height = "300px")
    ),
    arrow_color = "#505050",
    indicator_color = "#cccccc",
    active_indicator_color = "#ff0000",
    indicator_labels = c("Line Chart", "Column Chart", "Bar Chart"),
    indicator_shape = "square",
    container_height = 400
  )
)

server <- function(input, output, session) {
  output$plot1 <- renderHighchart({
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_add_series(data = rnorm(10), name = "Line Data")
  })
  
  output$plot2 <- renderHighchart({
    highchart() %>%
      hc_chart(type = "column") %>%
      hc_add_series(data = round(runif(10, 5, 15)), name = "Column Data")
  })
  
  output$plot3 <- renderHighchart({
    highchart() %>%
      hc_chart(type = "bar") %>%
      hc_add_series(data = sample(1:20, 10), name = "Bar Data")
  })
}

shinyApp(ui, server)

```

When you run this app, you’ll see a **carousel** that slides through three different highchart plots with custom arrows and square-labeled indicators.

## Usage

### Add `rcarousel` to your app:

1. Include the library at the top of your UI script:
   ```r
   library(rcarousel)
   ```
2. Call `rcarousel()` in your **UI**, passing a **list of modules** (e.g., `plotOutput`, `highchartOutput`, `tableOutput`, or any custom UI component).

---

### Adjust Appearance:

You can customize various visual aspects of the carousel:

- **`arrow_color`**: Changes the background color of navigation arrows (`prev`/`next`).
- **`indicator_color`**: Defines the color of inactive indicators.
- **`active_indicator_color`**: Defines the color of the active indicator (the current slide).
- **`indicator_shape`**:  
- `"circle"` → Dots (default).
- `"square"` → Buttons with text labels.
- **`container_height`**: Sets the total height in pixels to ensure both your content and navigation elements remain visible.

---

### Indicator Labels:

- If `indicator_shape = "square"`, you can display **text labels inside each button**.
- You can optionally pass a **vector of labels** using:

```r
indicator_labels = c("Slide1", "Slide2", "Slide3")
```
to show **tooltips or inline text** in the navigation buttons.
- **If `indicator_labels = NULL`**, default numeric labels (`"1"`, `"2"`, `"3"`, etc.) will be automatically assigned.
- **Important:** If you decide to provide custom labels, the number of labels **must match** the number of UI modules. Otherwise, `rcarousel` will throw an error.

---

### Validation:

- Ensure that the **length of `indicator_labels` matches the number of `modules`** if `indicator_labels` is not `NULL`.
- If they differ, `rcarousel` will **throw an error** to maintain consistency.

---

## Advanced Topics

### Autoplay / Timed Slides:

If you want **automatic transitions** (e.g., every 5 seconds), you can inject a small **JavaScript snippet** calling `nextSlide()` on an interval.

Example:


```js
setInterval(() => { nextSlide(); }, 5000);
```

This will automatically advance the carousel **every 5 seconds**.

---

### Dynamic Content:

You can include **any Shiny UI component** inside each `modules` slot, such as:

- Text (`textOutput`)
- Images (`img()`)
- Tables (`tableOutput`)
- Interactive visualizations (`plotOutput`, `highchartOutput`)
- Custom **HTML elements** (`tags$div`, `tags$img`, etc.)

---

## Contributing

Contributions are welcome! 🚀  
Please open an **[issue](https://github.com/youruser/rcarousel/issues)** or submit a **pull request** if you’d like to:

- **Report a bug**
- **Request a feature**
- **Improve the documentation**

Your feedback and contributions help make `rcarousel` better for everyone! 💡

---

## License

`rcarousel` is licensed under the **MIT License**.  
See the [`LICENSE`](./LICENSE) file for details.

```<div align="center"> Made with ❤️ by **[Robson Donato](https://github.com/youruser)**. </div> ```
