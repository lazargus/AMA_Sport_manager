const tournamentShowPrizeMoney = () => {
  const prizeMoneyChoice = document.querySelectorAll('.prize-money-choice');
  prizeMoneyChoice.forEach((choice) => {
    choice.addEventListener('click', (e) => {
      prizeMoneyChoice.forEach((c) => {
        if(c.classList.contains('active')){
          c.classList.remove('active')
        };
      });
      choice.classList.add('active');
    });
  });
};

export { tournamentShowPrizeMoney };

