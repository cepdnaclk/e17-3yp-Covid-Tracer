var ctx = document.getElementById('Chart1').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: [{% for stat in stats %}'{{stat.update_timestamp}}',{% endfor %}],
                datasets: [{
                    label: 'Number of Cases',
                    data: [{% for stat in stats %}{{stat.new_cases}},{% endfor %}],
                    backgroundColor: [
                        'rgb(0, 0, 51)'
                    ],
                    borderColor: [
                        'rgb(0, 0, 51)'
                    ],
                    borderWidth: 1,
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                maintainAspectRatio: false,
            }
        });