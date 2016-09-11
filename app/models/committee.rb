class Committee < ApplicationRecord
  self.primary_key = 'committee_id'

  has_many :subcommittees, class_name: 'Committee', foreign_key: :parent_committee_id, primary_key: :committee_id
  has_many :committee_memberships, foreign_key: :committee_id, primary_key: :committee_id
  has_many :legislators, through: :committee_memberships

  def chart_data
    {
      'Democrat' => legislators.where(party: 'D').count,
      'Republican' => legislators.where(party: 'R').count
    }
  end

  def highcharts_options
    {
      library: {
        plotOptions: {
          pie: {
            innerSize: '33%',
            startAngle: -90,
            endAngle: 90,
            center: ['50%', '100%'],
            size: '200%',
            colors: ['#0074D9', '#FF4136'],
            dataLabels: {
              enabled: false
            }
          }
        }
      }
    }
  end

end
