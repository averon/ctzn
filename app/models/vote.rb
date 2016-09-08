class Vote < ApplicationRecord
  has_many :cast_votes, foreign_key: :roll_id, primary_key: :roll_id
  has_many :legislators, through: :cast_votes

  def chart_data
    {
      'Yeas [D]' => summary['d_yeas'],
      'Yeas [I]' => summary['i_yeas'],
      'Yeas [R]' => summary['r_yeas'],
      'Nays [D]' => summary['d_nays'],
      'Nays [I]' => summary['i_nays'],
      'Nays [R]' => summary['r_nays'],
    }
  end

  def highcharts_options
    {
      library: {
        title: {
          text: question
        },
        plotOptions: {
          pie: {
            innerSize: '33%',
            startAngle: -90,
            endAngle: 90,
            center: ['50%', '100%'],
            size: '200%',
            colors: ['#0074D9', '#DDDDDD', '#FF4136', '#001f3f', '#AAAAAA', '#85144b'],
            dataLabels: {
              enabled: false
            }
          }
        }
      }
    }
  end
end
