    $(function() {
        /** This code runs when everything has been loaded on the page */
        /* Inline sparklines take their values from the contents of the tag */
        $('.inlinesparkline').sparkline('html', {type: 'bar',
                    width: '100',
                    height: '30',
                    lineColor: '#ff5656',
                    chartRangeMax: 5,
                    chartRangeMin: 0});

        $(".sparkpie").sparkline('html', {
                    type: 'pie',
                    height: '40'});

    });
