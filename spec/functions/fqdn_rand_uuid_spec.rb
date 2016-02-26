require 'spec_helper'

describe 'fqdn_rand_uuid' do

  context "Invalid parameters" do
    it { should run.with_params('a', 'b').and_raise_error(ArgumentError, /^fqdn_rand_uuid: Too many arguments given \(2\)$/) }
    it { should run.with_params(15).and_raise_error(Puppet::ParseError, /seed argument must be a string/) }
  end

  context "FQDN node.example.org" do
    let (:node) { 'node.example.org' }
    it { should run.with_params().and_return('30bf69f0-9cd1-5ef0-a3f6-849f29d61edc') }
    it { should run.with_params('').and_return('64cdcc65-a191-54e4-86a7-b92983a3911e') }
    it { should run.with_params('test').and_return('c4bfac63-94b4-5cbe-b681-5989ba6cdeb5') }
  end

  context "FQDN othernode.example.org" do
    let (:node) { 'othernode.example.org' }
    it { should run.with_params().and_return('b9e0bc4d-2a7b-5cb6-9b7c-14bd55705b37') }
    it { should run.with_params('').and_return('1d819a9a-342e-58ac-831a-2e8665e1391f') }
    it { should run.with_params('test').and_return('d6fd13f3-b21f-55c2-9c56-c61edbb3f492') }
  end

end
