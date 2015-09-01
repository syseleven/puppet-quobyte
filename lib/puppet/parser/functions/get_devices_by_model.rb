module Puppet::Parser::Functions
  newfunction(:get_devices_by_model, :type => :rvalue) do |args|
  ret = []

  models_wanted = args[0]

  models_wanted.each do |model_wanted|

    blockdevices = lookupvar('blockdevices').split(',')
    blockdevices.each do |blockdevice|
      model = lookupvar("blockdevice_#{blockdevice}_model")
      Puppet.notice("#{model} - #{model_wanted}")
      if model == model_wanted
        ret << "/dev/" + blockdevice
      end
    end

  end
  ret
  end
end
