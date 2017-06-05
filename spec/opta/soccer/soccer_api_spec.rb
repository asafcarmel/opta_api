require 'spec_helper'
require 'opta/soccer/soccer_api'

describe Opta::Soccer::SoccerApi, vcr: {
  cassette_name: 'opta_soccer_api',
  record: :new_episodes,
  match_requests_on: [:uri]
  } do

    let(:api) { Opta::Soccer::SoccerApi.new(get_token) }
    let(:epl_id)   { '2c1fh40r28amu4rgz0q66ago9' }
    let(:match_id) { '8w7z37x3qwv3kyciiqqfax8tl' }
    context 'Soccer API' do
      describe 'squads' do
        let(:arsenal) { { 'competitionId' => '2kwbbcootiqqgmrzs6o5inle5',
          'competitionName' => 'Premier League',
          'contestantClubName' => 'Chelsea',
          'contestantCode' => 'CHE',
          'contestantId' => '9q0arba2kbnywth8bkxlhgmdr',
          'contestantName' => 'Chelsea FC',
          'contestantShortName' => 'Chelsea',
          'teamType' => 'club',
          'type' => 'squad',
          } }
          it 'fetches teams' do
            squads = api.squads(epl_id)
            expect(squads['squad'].size).to eq(20)
            expect(squads['squad'].first.reject!{ |k| k == 'person' }).to eql(arsenal)
          end
        end

        describe 'match_list' do
          let(:hull_vs_leicester) { {'description'=>'Hull City vs Leicester City', 'sport'=>{'id'=>'289u5typ3vp4ifwh5thalohmq', 'name'=>'Soccer'}, 'ruleset'=>{'id'=>'79plas4983031idr6vw83nuel', 'name'=>'Men'}, 'competition'=>{'id'=>'2kwbbcootiqqgmrzs6o5inle5', 'name'=>'Premier League', 'country'=>{'id'=>'1fk5l4hkqk12i7zske6mcqju6', 'name'=>'England'}}, 'tournamentCalendar'=>{'id'=>'2c1fh40r28amu4rgz0q66ago9', 'startDate'=>'2016-08-13Z', 'endDate'=>'2017-05-21Z', 'name'=>'Premier League 2016/2017'}, 'contestant'=>[{'id'=>'f0figafm2v9h8ofo6slajj7xf', 'name'=>'Hull City', 'country'=>{'id'=>'1fk5l4hkqk12i7zske6mcqju6', 'name'=>'England'}, 'position'=>'home'}, {'id'=>'avxknfz4f6ob0rv9dbnxdzde0', 'name'=>'Leicester City', 'country'=>{'id'=>'1fk5l4hkqk12i7zske6mcqju6', 'name'=>'England'}, 'position'=>'away'}], 'venue'=>{'id'=>'7a39nonqc648smp9biv3c1c6u', 'shortName'=>'Kingston Communications Stadium', 'longName'=>'Kingston Communications Stadium'}, 'id'=>'8w7z37x3qwv3kyciiqqfax8tl', 'date'=>'2016-08-13Z', 'time'=>'11:30:00Z', 'week'=>'1', 'lastUpdated'=>'2016-08-13T22:40:02Z'} }
          it 'fetches season matches' do
            matches = api.match_list(epl_id)
            expect(matches['match'].size).to eq(380)
            expect(matches['match'].last['matchInfo']).to eql(hull_vs_leicester)
          end
        end

        describe 'match_statistics' do
          let(:jakupovic) { {'firstName'=>'Eldin', 'lastName'=>'Jakupovic', 'matchName'=>'E. Jakupovic', 'playerId'=>'832arq1qtwnwbki4v3vuj49n9', 'shirtNumber'=>16, 'position'=>'Goalkeeper', 'positionSide'=>'Centre', 'stat'=>[{'type'=>'divingSave', 'value'=>'1'}, {'type'=>'leftsidePass', 'value'=>'2'}, {'type'=>'accuratePass', 'value'=>'12'}, {'type'=>'totalFinalThirdPasses', 'value'=>'11'}, {'type'=>'rightsidePass', 'value'=>'2'}, {'type'=>'attemptsConcededIbox', 'value'=>'9'}, {'type'=>'touches', 'value'=>'35'}, {'type'=>'totalFwdZonePass', 'value'=>'26'}, {'type'=>'keeperPickUp', 'value'=>'5'}, {'type'=>'accurateFwdZonePass', 'value'=>'9'}, {'type'=>'lostCorners', 'value'=>'1'}, {'type'=>'goalsConceded', 'value'=>'1'}, {'type'=>'saves', 'value'=>'4'}, {'type'=>'attemptsConcededObox', 'value'=>'9'}, {'type'=>'ballRecovery', 'value'=>'6'}, {'type'=>'possWonDef3rd', 'value'=>'1'}, {'type'=>'accurateBackZonePass', 'value'=>'3'}, {'type'=>'diveSave', 'value'=>'1'}, {'type'=>'passesRight', 'value'=>'3'}, {'type'=>'successfulOpenPlayPass', 'value'=>'4'}, {'type'=>'penaltyFaced', 'value'=>'1'}, {'type'=>'totalBackZonePass', 'value'=>'5'}, {'type'=>'totalLongBalls', 'value'=>'28'}, {'type'=>'goalsConcededIbox', 'value'=>'1'}, {'type'=>'goalKicks', 'value'=>'12'}, {'type'=>'openPlayPass', 'value'=>'11'}, {'type'=>'totalPass', 'value'=>'31'}, {'type'=>'totalLaunches', 'value'=>'13'}, {'type'=>'fwdPass', 'value'=>'27'}, {'type'=>'gameStarted', 'value'=>'1'}, {'type'=>'longPassOwnToOpp', 'value'=>'26'}, {'type'=>'successfulFinalThirdPasses', 'value'=>'2'}, {'type'=>'passesLeft', 'value'=>'11'}, {'type'=>'accurateLaunches', 'value'=>'2'}, {'type'=>'possLostAll', 'value'=>'19'}, {'type'=>'accurateLongBalls', 'value'=>'9'}, {'type'=>'accurateGoalKicks', 'value'=>'6'}, {'type'=>'savedObox', 'value'=>'2'}, {'type'=>'possLostCtrl', 'value'=>'19'}, {'type'=>'penGoalsConceded', 'value'=>'1'}, {'type'=>'finalThirdEntries', 'value'=>'11'}, {'type'=>'penAreaEntries', 'value'=>'1'}, {'type'=>'minsPlayed', 'value'=>'90'}, {'type'=>'longPassOwnToOppSuccess', 'value'=>'9'}, {'type'=>'savedIbox', 'value'=>'2'}, {'type'=>'formationPlace', 'value'=>'1'}]} }

          it 'fetches match_statistics' do
            stats = api.match_statistics(match_id)
            lineup = stats['liveData']['lineUp']
            expect(lineup[0]['player'].count).to eq(18)
            expect(lineup[1]['player'].count).to eq(18)

            expect(lineup[0]['player'].select{|p| p['lastName']=='Jakupovic'}.first).to eql(jakupovic)
          end
        end

        describe 'match_event' do
          let(:match_event) { {} }
          it 'fetches match_event' do
            events = api.match_event(match_id)
            expect(events['liveData']['event'].size).to eq(1742)
          end
        end

        describe 'tournament_schedule' do
          let(:tournament_schedule) { {} }
          let(:europa_league_id) { "4jvp2pwv9xdhy5udpuvwqofzd" }
          it 'fetches tournament_schedule' do
            events = api.tournament_schedule(europa_league_id)
            expect(events['matchDate'].count).to eq(32)
          end
        end

      end
    end
