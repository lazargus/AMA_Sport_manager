import Chart from 'chart.js';

const initChart = (data) => {
  const ctx = document.getElementById("chartEarnings")
  const chartExpense = new Chart(ctx, {
    type: 'line',
    data: data,
    options: {
      scales: {
        yAxes: [{
          gridLines: {
            display: false
          },
          ticks: {
            beginAtZero: true
          }
        }]
      },
      responsive: true,
      aspectRatio: 1,
      maintainAspectRatio: false
    }
  });
}

const loadData = (url) => {
  return new Promise((resolve, reject) => {
    fetch(url)
      .then(response => response.json())
      .then(data => {
        resolve(data)
      });
  });

}

const buildChart = () => {
  let earningData = null;
  loadData("/earnings.json")
    .then(data => {
      earningData = data;
      loadData("/expenses.json")
        .then(data => {
          earningData.datasets.push(data)
          initChart(earningData);
          // initChart2(earningData);
        })
    })

}

const initDonut = (data) => {
  const ctx = document.getElementById("chartExpenses")
  if (ctx) {
    fetch("/expenses/donut.json")
      .then(response => response.json())
      .then(data => {
        const chartExpense = new Chart(ctx, {
          type: 'doughnut',
          data: data,
          options: {
            scales: {
              xAxes: [{
                gridLines: {
                  display: false
                },
                ticks: {
                  beginAtZero: true,
                  display: false
                }
              }]
            },
            responsive: true,
            aspectRatio: 1,
            maintainAspectRatio: false
          }
        });
      });
  }
}

export { buildChart, initDonut }
