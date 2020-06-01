import Chart from 'chart.js';

const initChart = (data) => {
  const ctx = document.getElementById("chartExpense")
  const chartExpense = new Chart(ctx, {
    type: 'line',
    data: data, 
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});
}

const buildChart = () => {
  fetch("/earnings.json")
  .then(response => response.json())
  .then(data => {
    console.log(data);
    initChart(data)
  });

}

export { buildChart }
