require 'net/http'
require 'nokogiri'

class Vote < ApplicationRecord
  def self.scrub_params(hash)
    hash.select { |k| self.attribute_names.index(k) }
  end

  def roll
    @roll ||= Nokogiri::HTML(Net::HTTP.get(URI(url)))
  end

  def votes
    roll.search('recorded-vote')
  end

  def chart_data
    {
      'Yeas [D]' => d_yeas,
      'Yeas [I]' => i_yeas,
      'Yeas [R]' => r_yeas,
      'Nays [D]' => d_nays,
      'Nays [I]' => i_nays,
      'Nays [R]' => r_nays,
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

  def r_yeas
    roll.search('yea-total')[0].children[0].text.to_i
  end

  def r_nays
    roll.search('nay-total')[0].children[0].text.to_i
  end

  def d_yeas
    roll.search('yea-total')[1].children[0].text.to_i
  end

  def d_nays
    roll.search('nay-total')[1].children[0].text.to_i
  end

  def i_yeas
    roll.search('yea-total')[2].children[0].text.to_i
  end

  def i_nays
    roll.search('nay-total')[2].children[0].text.to_i
  end

  def yeas_total
    roll.search('yea-total')[3].children[0].text.to_i
  end

  def nays_total
    roll.search('nay-total')[3].children[0].text.to_i
  end

  def total
    yeas_total + nays_total
  end
end
