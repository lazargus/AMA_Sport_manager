
const tournamentsCardsHover = () => {
  const tournamentCards = document.querySelectorAll('.tournament-card');
  tournamentCards.forEach((card) => {
    card.addEventListener('mouseover', (e) => {
      const imgUrl = card.dataset.imgUrl;
      card.style.backgroundImage = `linear-gradient(153deg, rgba(3,56,96,1) 0%, rgba(5,80,136,0.8057598039215687) 50%, rgba(20,101,163,0.8169642857142857) 100%), url(${imgUrl})`;
    });

    card.addEventListener('mouseout', (e) => {
      const imgUrl = card.dataset.imgUrl;
      card.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.5),rgba(0,0,0,0.5)), url(${imgUrl})`;
    });
  });
}

export { tournamentsCardsHover }
