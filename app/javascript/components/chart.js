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
            color: "rgba(0, 0, 0, 0)",
        },
          ticks: {
            beginAtZero: true
            
          }
        }]
      }
    }
  });
}

// const initChart2 = (data) => {
//   const ctx = document.getElementById("chartForecasts")
//   const chartExpense = new Chart(ctx, {
//     type: 'line',
//     data: data,
//     options: {
//       scales: {
//         yAxes: [{
//           ticks: {
//             beginAtZero: true
//           }
//         }]
//       }
//     }
//   });
// }

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
          initChart2(earningData);
        })
    })
}

export { buildChart }
