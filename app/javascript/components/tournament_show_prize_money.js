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
  const prize = choice.querySelectorAll('p:nth-child(4)')[0].textContent;
  const form = document.getElementById('earning_forecast_amount');
  form.value = prize;
    });
  });

};

export { tournamentShowPrizeMoney };

