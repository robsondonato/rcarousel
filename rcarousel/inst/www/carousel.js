let currentIndex = 0;

function showSlide(index) {
  let track = document.getElementsByClassName('carousel-track')[0];
  let slides = document.getElementsByClassName('carousel-slide');
  let indicators = document.getElementsByClassName('carousel-indicator');
  let total = slides.length;

  if (index >= total) {
    currentIndex = 0;
  } else if (index < 0) {
    currentIndex = total - 1;
  } else {
    currentIndex = index;
  }

  // remove 'active' de todos os indicadores
  for (let i = 0; i < total; i++) {
    indicators[i].classList.remove('active');
  }
  indicators[currentIndex].classList.add('active');

  // Move a track p/ exibir o slide atual
  track.style.transform = 'translateX(-' + (currentIndex * 100) + '%)';
}

function nextSlide() {
  showSlide(currentIndex + 1);
}

function prevSlide() {
  showSlide(currentIndex - 1);
}

function goToSlide(index) {
  showSlide(index);
}

// Inicia no slide 0 ao carregar a página
document.addEventListener('DOMContentLoaded', function() {
  showSlide(0);
});
