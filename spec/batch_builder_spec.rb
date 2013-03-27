require 'spec_helper'

describe Emarsys::Broadcast::BatchBuilder do
  describe 'initialize' do
    context 'with valid options' do
      let(:options){options = {name: 'batch_name', send_time: Time.now, sender: 'test@example.com'}}
      let(:batch_builder){batch_builder = Emarsys::Broadcast::BatchBuilder.new(options)}

      it 'should create a new instance of BatchBuilder from valid options' do
        expect(batch_builder).not_to be_nil
      end

      it 'should init attributes from required option keys' do
        expect(batch_builder.name).to eq 'batch_name'
        expect(batch_builder.send_time).not_to be_nil
        expect(batch_builder.sender).to eq 'test@example.com'
      end
    end

    context 'with invalid options' do
      it 'should raise ArgumentError when options is nil' do
        expect{Emarsys::Broadcast::BatchBuilder.new(nil)}.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options does not contain a valid name' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new(send_time: Time.now, sender: 'test@example.com')
        }.to raise_error ArgumentError

        expect{
          Emarsys::Broadcast::BatchBuilder.new(name: '', send_time: Time.now, sender: 'test@example.com')
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options does not contain a valid send_time' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new(name: 'batch_name', sender: 'test@example.com')
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options does not contain a sender' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new(send_time: Time.now, name: 'batch_name')
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options contains empty sender' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new(name: 'batch_name', send_time: Time.now, sender: '')
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options contains invalid sender email' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new(name: 'batch_name', send_time: Time.now, sender: 'invalid@sender yo')
        }.to raise_error ArgumentError
      end
    end
  end
end