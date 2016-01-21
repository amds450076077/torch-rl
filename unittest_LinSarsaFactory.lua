require 'LinSarsaFactory'
require 'LinSarsa'
require 'TestMdp'
require 'TestSAFE'
require 'MdpConfig'
local tester = torch.Tester()

local mdp = TestMdp()
local discount_factor = 0.631
local TestLinSarsaFactory = {}
function TestLinSarsaFactory.test_get_control()
    local mdp_config = MdpConfig(mdp, discount_factor)
    local lambda = 0.65
    local eps = 0.2437
    local feature_extractor = TestSAFE()
    local step_size = 0.92

    local lin_sarsa = LinSarsa(mdp_config, lambda, eps, feature_extractor, step_size)
    local factory = LinSarsaFactory(mdp_config, lambda, eps, feature_extractor, step_size)
    tester:assert(factory:get_control() == lin_sarsa)
end

tester:add(TestLinSarsaFactory)

tester:run()
