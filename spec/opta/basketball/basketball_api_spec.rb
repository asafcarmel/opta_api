require 'spec_helper'
require 'opta/basketball/basketball_api'

describe Opta::Basketball::BasketballApi, vcr: {
  cassette_name: 'opta_basketball_api',
  record: :new_episodes,
  match_requests_on: [:uri]
  } do

    let(:api) { Opta::Basketball::BasketballApi.new(get_token) }
    let(:season_id) { '8znop8ppwnewt536p1zda3pbd' }
    let(:match_id)  { '4tpl1bi14dn5hu7jw57jr171l' }

    context 'Basketball API' do
      describe 'squads' do
        it 'fetches teams' do
          squads = api.squads(season_id)
          expect(squads['squad'].size).to eq(35)
          expect(squads['squad'][8]['person'].size).to eq(16)
          expect(squads['squad'][8]['contestantName']).to eql('Philadelphia 76ers')
        end
      end

      describe 'match_list' do
        let(:celtics_vs_bulls) { {'matchInfo'=>{'id'=>'4tpl1bi14dn5hu7jw57jr171l', 'date'=>'2015-12-10Z', 'time'=>'00:00:00Z', 'lastUpdated'=>'2015-12-10T03:16:02Z', 'description'=>'Boston Celtics vs Chicago Bulls', 'sport'=>{'id'=>'ayp4nebmprfbvzdsisazcw74y', 'name'=>'basketball'}, 'ruleset'=>{'id'=>'', 'name'=>'Men'}, 'competition'=>{'id'=>'e2w9iicoifx689pzi5jqw7j4a', 'name'=>'NBA', 'country'=>{'id'=>'7hr2f89v44y65dyu9k92vprwn', 'name'=>'USA'}}, 'tournamentCalendar'=>{'id'=>'8znop8ppwnewt536p1zda3pbd', 'startDate'=>'2015-10-03Z', 'endDate'=>'2016-06-20Z', 'name'=>'2015/2016'}, 'stage'=>{'id'=>'2pybifgzi2evov5mele3mrtnt', 'startDate'=>'2015-10-28Z', 'endDate'=>'2016-04-14Z', 'name'=>'Regular Season'}, 'contestant'=>[{'id'=>'2w4j5p0pwwlxmcd5vceuu0rrv', 'name'=>'Boston Celtics', 'country'=>{'id'=>'7hr2f89v44y65dyu9k92vprwn', 'name'=>'USA'}, 'position'=>'home'}, {'id'=>'cfqu8fhvtu5hm13vrwxeh4x05', 'name'=>'Chicago Bulls', 'country'=>{'id'=>'7hr2f89v44y65dyu9k92vprwn', 'name'=>'USA'}, 'position'=>'away'}], 'venue'=>{'id'=>'2v3g5idigftq9972bxitonzdl', 'shortName'=>'TD Garden'}}, 'liveData'=>{'matchDetails'=>{'matchStatus'=>'Played', 'matchType'=>'NBA', 'matchTimeMin'=>48, 'matchTimeSec'=>0, 'periodTimeMin'=>0, 'periodTimeSec'=>0, 'periodId'=>15, 'scores'=>{'q1'=>{'home'=>24, 'away'=>24}, 'q2'=>{'home'=>27, 'away'=>30}, 'q3'=>{'home'=>24, 'away'=>21}, 'q4'=>{'home'=>30, 'away'=>25}, 'total'=>{'home'=>105, 'away'=>100}}}}} }
        it 'fetches season matches' do
          matches = api.match_list(season_id)
          expect(matches['match'].size).to eq(1428)
          expect(matches['match'][0]).to eql(celtics_vs_bulls)
        end
      end

      describe 'match_statistics' do
        it 'fetches match_statistics' do
          stats = api.match_statistics(match_id)
          lineup = stats['liveData']['lineUp']
          expect(lineup[0]['player'].count).to eq(13)
          expect(lineup[1]['player'].count).to eq(13)
        end
      end

    end
  end
