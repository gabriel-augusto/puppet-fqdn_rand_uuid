require 'digest/sha1'

module Puppet::Parser::Functions
  newfunction(:fqdn_rand_uuid, :type => :rvalue, :doc => <<-END) do |args|

    Creates a UUID based on the node's FQDN and an optional seed value.

    Usage:

      $uuid = fqdn_rand_uuid([$seed])

    The seed is optional. If given it must be a string.
    The generated UUID will be the same for a given hostname and seed.

    The resulting UUID is returned on the form:

      1d839dea-5e10-5243-88eb-e66815bd7d5c

    (I.e. without any curly braces.)

    The generated UUID is a version 5 UUID with a custom namespace ID.

    END

    fqdn = lookupvar('::fqdn')

    if args.length == 0
      seed = nil
    elsif args.length == 1
      seed = args[0]
      unless seed.is_a?(String)
        raise(Puppet::ParseError, 'fqdn_rand_uuid(): seed argument must be a string')
      end
    else
      raise(ArgumentError, "fqdn_rand_uuid: Too many arguments given (#{args.length})")
    end

    # The UUID for our namespace (0b7a81ff-db8d-42fe-8d9f-768ea5b8ed1a)
    ns_uuid = "\x0b\x7a\x81\xff\xdb\x8d\x42\xfe\x8d\x9f\x76\x8e\xa5\xb8\xed\x1a"

    hash_input = ns_uuid + fqdn
    unless seed.nil?
      hash_input += "\x00" + seed
    end

    hash = Digest::SHA1.digest(hash_input)
    hash = hash.bytes.to_a

    uuid = hash[0,16]

    # The version (5) goes in the top four most significant bits of the
    # time_hi_and_version field. This field starts at byte 6.
    uuid[6] = (uuid[6] & 0x0f) | 0x50

    # Set the reserved bits of click_seq_hi_and_reserved to 0b10. This field
    # is in byte 8.
    uuid[8] = (uuid[8] & 0b00111111) | 0b10000000

    # Format the UUID in groups of 4, 2, 2, 2 and 8 bytes
    uuid = [4,2,2,2,8].map do |count|
      group = uuid.shift(count)
      group = group.map { |byte| sprintf('%02x', byte) }
      group = group.join()
      group
    end
    uuid = uuid.join('-')

    uuid
  end
end
