require 'Easy21BoxSAFE'

local tester = torch.Tester()

local TestEasy21BoxSAFE = {}
function TestEasy21BoxSAFE.test_onehot_fe()
    local s = {1, 2}
    local a = {1}
    local fe = Easy21BoxSAFE()
    local f = fe:get_sa_features(s, a)
    local expected = torch.zeros(36)
    expected[1] = 1

    tester:assertTensorEq(f, expected, 0)
end

function TestEasy21BoxSAFE.test_manyhot_fe()
    local s = {4, 5}
    local a = {1}
    local fe = Easy21BoxSAFE()
    local f = fe:get_sa_features(s, a)
    local expected = torch.zeros(36)
    expected[1] = 1
    expected[3] = 1
    expected[13] = 1
    expected[15] = 1

    tester:assertTensorEq(f, expected, 0)
end

function TestEasy21BoxSAFE.test_invalid_state()
    local fe = Easy21BoxSAFE()
    local expected = torch.zeros(N_DEALER_STATES * N_PLAYER_STATES * N_ACTIONS)

    local s = {-1, 4}
    local a = {2}
    local get_sa_features = function ()
        return fe:get_sa_features(s, a)
    end
    tester:assertError(get_feature)
end

function TestEasy21BoxSAFE.test_invalid_state2()
    local fe = Easy21BoxSAFE()
    local expected = torch.zeros(N_DEALER_STATES * N_PLAYER_STATES * N_ACTIONS)

    local s = {1, 4}
    local a = {3}
    local get_sa_features = function ()
        return fe:get_sa_features(s, a)
    end
    tester:assertError(get_feature)
end

tester:add(TestEasy21BoxSAFE)
tester:run()