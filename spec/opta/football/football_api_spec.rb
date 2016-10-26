require 'spec_helper'
require 'opta/football/football_api'

describe Opta::Football::FootballApi, vcr: {
  cassette_name: 'opta_football_api',
  record: :new_episodes,
  match_requests_on: [:uri]
  } do

    let(:api) { Opta::Football::FootballApi.new(get_token) }
    let(:season_id) { 'yziuwyn01o8wk9y2i41dqrs0' }
    let(:match_id)  { 'dpk2xk0r333zq5eenfhbwbwsn' }

    context 'Football API' do
      describe 'squads' do
        it 'fetches teams' do
          squads = api.squads(season_id)
          expect(squads['squad'].size).to eq(34)
          expect(squads['squad'][6]['person'].size).to eq(78)
          expect(squads['squad'][6]['contestantName']).to eql('Los Angeles Rams')
        end
      end

      describe 'match_list' do
        let(:buccaneers_vs_bengals) { {"matchInfo"=>{"description"=>"Tampa Bay Buccaneers vs Cincinnati Bengals", "sport"=>{"id"=>"9ita1e50vxttzd1xll3iyaulu", "name"=>"American Football"}, "ruleset"=>{"id"=>"523t1qaz9d9alk9mkm03f00sa", "name"=>"Men"}, "competition"=>{"id"=>"wy3kluvb4efae1of0d8146c1", "name"=>"NFL", "country"=>{"id"=>"7hr2f89v44y65dyu9k92vprwn", "name"=>"USA"}}, "tournamentCalendar"=>{"id"=>"yziuwyn01o8wk9y2i41dqrs0", "startDate"=>"2015-08-08Z", "endDate"=>"2016-01-29Z", "name"=>"NFL 2015/2016"}, "stage"=>{"id"=>"3k3o5h8a3ga7rt349fqywaep5", "startDate"=>"2015-08-08Z", "endDate"=>"2015-09-03Z", "name"=>"Pre Season"}, "contestant"=>[{"id"=>"3qjw9mvbhdo21c29ox0hnywiu", "name"=>"Tampa Bay Buccaneers", "country"=>{"id"=>"7hr2f89v44y65dyu9k92vprwn", "name"=>"United States"}, "position"=>"home"}, {"id"=>"d2rtnr51xhtuvmj91br71osg3", "name"=>"Cincinnati Bengals", "country"=>{"id"=>"7hr2f89v44y65dyu9k92vprwn", "name"=>"United States"}, "position"=>"away"}], "venue"=>{"id"=>"ey0o8ti8tdklju2635sbab1d", "shortName"=>"Raymond James Stadium"}, "id"=>"dpk2xk0r333zq5eenfhbwbwsn", "date"=>"2015-08-25Z", "time"=>"00:00:00Z", "week"=>2, "lastUpdated"=>"2015-10-30T11:48:30Z"}, "liveData"=>{"matchDetails"=>{"matchStatus"=>"Played", "matchType"=>"NFL", "matchTimeMin"=>60, "matchTimeSec"=>0, "periodTimeMin"=>0, "periodTimeSec"=>0, "periodId"=>15, "scores"=>{"q1"=>{"home"=>7, "away"=>0}, "q2"=>{"home"=>16, "away"=>3}, "q3"=>{"home"=>0, "away"=>0}, "q4"=>{"home"=>2, "away"=>8}, "total"=>{"home"=>25, "away"=>11}}}, "score"=>[{"periodId"=>"1", "contestantId"=>"3qjw9mvbhdo21c29ox0hnywiu", "scorerId"=>"85jrh2w8h2ciy601gnit8lcyx", "scorerName"=>"J. Winston", "eventId"=>"11625", "type"=>"TD", "timeMin"=>10, "timeSec"=>59, "lastUpdated"=>"2015-08-25T00:12:40Z"}, {"periodId"=>"1", "contestantId"=>"3qjw9mvbhdo21c29ox0hnywiu", "scorerId"=>"673vca4gc12vlpfkf08zpl4vd", "scorerName"=>"P. Murray", "eventId"=>"11626", "type"=>"XP", "timeMin"=>10, "timeSec"=>57, "lastUpdated"=>"2015-08-25T00:13:33Z"}, {"periodId"=>"2", "contestantId"=>"3qjw9mvbhdo21c29ox0hnywiu", "scorerId"=>"5daue105l6p47xgert9sfztux", "scorerName"=>"A. Verner", "eventId"=>"11710", "type"=>"TD", "timeMin"=>11, "timeSec"=>20, "lastUpdated"=>"2015-08-25T01:00:17Z"}, {"periodId"=>"2", "contestantId"=>"3qjw9mvbhdo21c29ox0hnywiu", "scorerId"=>"673vca4gc12vlpfkf08zpl4vd", "scorerName"=>"P. Murray", "eventId"=>"11711", "type"=>"XP", "timeMin"=>11, "timeSec"=>17, "lastUpdated"=>"2015-08-25T01:00:42Z"}, {"periodId"=>"2", "contestantId"=>"3qjw9mvbhdo21c29ox0hnywiu", "scorerId"=>"46fh784vzlce0zfs51zl94esp", "scorerName"=>"R. Shepard", "eventId"=>"11725", "type"=>"TD", "timeMin"=>8, "timeSec"=>47, "lastUpdated"=>"2015-08-25T01:10:41Z"}, {"periodId"=>"2", "contestantId"=>"3qjw9mvbhdo21c29ox0hnywiu", "scorerId"=>"673vca4gc12vlpfkf08zpl4vd", "scorerName"=>"P. Murray", "eventId"=>"11739", "type"=>"FG", "timeMin"=>7, "timeSec"=>14, "lastUpdated"=>"2015-08-25T01:19:42Z"}, {"periodId"=>"2", "contestantId"=>"d2rtnr51xhtuvmj91br71osg3", "scorerId"=>"bdmkuxq8ldguegstx5wk9p8mh", "scorerName"=>"T. Obarski", "eventId"=>"11757", "type"=>"FG", "timeMin"=>2, "timeSec"=>49, "lastUpdated"=>"2015-08-25T01:29:17Z"}, {"periodId"=>"4", "contestantId"=>"3qjw9mvbhdo21c29ox0hnywiu", "scorerId"=>"an8m6klhbnevrm2b34032n6y1", "scorerName"=>"D. Lansanah", "eventId"=>"11871", "type"=>"Safety", "timeMin"=>14, "timeSec"=>13, "lastUpdated"=>"2015-08-25T02:36:27Z"}, {"periodId"=>"4", "contestantId"=>"d2rtnr51xhtuvmj91br71osg3", "scorerId"=>"eyvxnbcs25we1s6d1cu6pwnop", "scorerName"=>"J. Wilder Jr.", "eventId"=>"11916", "type"=>"TD", "timeMin"=>2, "timeSec"=>47, "lastUpdated"=>"2015-08-25T02:54:59Z"}, {"periodId"=>"4", "contestantId"=>"d2rtnr51xhtuvmj91br71osg3", "scorerId"=>"eyvxnbcs25we1s6d1cu6pwnop", "scorerName"=>"J. Wilder Jr.", "eventId"=>"11921", "timeMin"=>2, "timeSec"=>45, "lastUpdated"=>"2015-08-25T02:56:41Z"}]}} }
        it 'fetches season matches' do
          matches = api.match_list(season_id)
          expect(matches['match'].size).to eq(333)
          expect(matches['match'][300]).to eql(buccaneers_vs_bengals)
        end
      end

      describe 'match_statistics' do
        it 'fetches match_statistics' do
          stats = api.match_statistics(match_id)
          lineup = stats['liveData']['lineUp']
          expect(lineup[0]['player'].count).to eq(47)
          expect(lineup[1]['player'].count).to eq(50)
        end
      end

    end
  end
